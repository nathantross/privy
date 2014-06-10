exports = this
exports.Messages = new Meteor.Collection('messages')

Meteor.methods
  createMessage: (messageAttr) ->
    user = Meteor.user()
    threadId = messageAttr.threadId
    thread = Threads.findOne(threadId)
    hasExited = messageAttr.hasExited

    unless user
      throw new Meteor.Error(401, "You have to login to create a message.")

    unless messageAttr.body
      throw new Meteor.Error(422, 'Woops, looks like your message is blank!')
    
    unless threadId
      throw new Meteor.Error(404, "Thread does not exist to create a message.")

    if hasExited? && typeof hasExited != "boolean"
      throw new Meteor.Error(400, "hasExited must be set to true or false.")

    # Server validations
    if Meteor.isServer

      unless Notify.isParticipant(user._id, threadId)
        throw new Meteor.Error 401, "You can't create messages on this thread."

    # isRead should be true if any of the participants is in the room
    isRead = hasExited?
    
    if !isRead && (thread || Meteor.isServer)
      for participant in thread.participants
        if participant.userId != user._id && participant.isInThread
          isRead = true
    
    now = new Date().getTime()
    message = _.extend(_.pick(messageAttr, 'threadId', 'body'),
      senderId: user._id
      createdAt: now
      updatedAt: now
      isRead: isRead 
    )    
    
    message.hasExited = hasExited if hasExited?

    msgId = Messages.insert(message)

    if Meteor.isClient
      mixpanel.track("Message: created", {
        threadId: threadId
        userId: user._id
      })

    msgId

  readMessage: (threadId) ->  
    user = Meteor.user()
    
    index = Notify.userIndex(threadId)
      
    unless user
      throw new Meteor.Error(401, "You have to login to update a message.")
    
    unless threadId
        throw new Meteor.Error(404, "The threadId does not exist.")
    
    # Server validations
    if Meteor.isServer
      thread = Threads.findOne(threadId)
      
      unless thread
        throw new Meteor.Error(404, "This thread does not exist.")

      unless thread.participants[index].userId == user._id
        throw new Meteor.Error(401, "You can't read messages on this thread.")

    # whitelisted keys
    now = new Date().getTime()
    messages = Messages.update
        threadId: threadId
        senderId: 
          $ne: user._id
        isRead: false
      , 
        $set:
          isRead: true
          updatedAt: now
      ,
        multi: true
        
    # Decrement the notification count by the messages read
    Notify.changeCount(-1*messages) unless messages == 0