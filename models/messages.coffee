exports = this
exports.Messages = new Meteor.Collection('messages')

Meteor.methods
  createMessage: (messageAttr) ->
    user = Meteor.user()
    threadId = messageAttr.threadId
    thread = Threads.findOne(threadId)

    unless user
      throw new Meteor.Error(401, "You have to login to create a message.")

    unless messageAttr.body
      throw new Meteor.Error(422, 'Woops, looks like your message is blank!')
    
    unless threadId
      throw new Meteor.Error(404, "Thread does not exist to create a message.")

    unless Notify.isParticipant(user._id, threadId)
      throw new Meteor.Error(401, "You can't create messages on this thread.")

    # isRead should be true if any of the participants is in the room
    isRead = false
    if thread || Meteor.isServer
      for participant in thread.participants
        if participant.userId != user._id && participant.isInThread
          isRead = true
 
    Notify.changeCount(1) unless isRead
    
    now = new Date().getTime()
    message = _.extend(_.pick(messageAttr, 'threadId', 'body'),
      senderId: user._id
      createdAt: now
      updatedAt: now
      isRead: isRead 
    )    

    Messages.insert(message)


  readMessage: (threadId) ->  
    user = Meteor.user()
    thread = Threads.findOne(threadId)
    index = Notify.userIndex(threadId)
      
    unless user
      throw new Meteor.Error(401, "You have to login to update a message.")

    unless threadId
      throw new Meteor.Error(404, "The threadId does not exist.")
    
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