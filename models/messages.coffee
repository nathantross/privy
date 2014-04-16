exports = this
exports.Messages = new Meteor.Collection('messages')

Meteor.methods
  createMessage: (messageAttributes) ->
    user = Meteor.user()

    # special call for replies
    if messageAttributes.noteId && Meteor.isServer
      messageAttributes.threadId = 
        Threads.findOne(noteId: messageAttributes.noteId)._id

    if !user
      throw new Meteor.Error(401, "You have to login to create a message.")

    if !messageAttributes.body
      throw new Meteor.Error(422, 'Woops, looks like your message is blank!')
    
    if !messageAttributes.threadId
      throw new Meteor.Error(404, "This thread does not exist.")

    now = new Date().getTime()
    
    # isRead should be true if any of the participants is in the room
    participants = Threads.findOne(messageAttributes.threadId).participants
    isRead = false
    for participant in participants
      if participant.userId != user._id && participant.isInThread
        isRead = true

    message = _.extend(_.pick(messageAttributes, 'threadId', 'body'),
      senderId: user._id
      createdAt: now
      updatedAt: now
      isRead: isRead
    )     

    Messages.insert(message)


  readMessage: (threadId) ->  
    user = Meteor.user()
    thread = Threads.findOne(threadId)
      
    unless user
      throw new Meteor.Error(401, "You have to login to update a message.")

    unless threadId
      throw new Meteor.Error(404, "The threadId does not exist.")
    
    unless thread
      throw new Meteor.Error(404, "This thread does not exist.")

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
    unless messages == 0
      console.log "Messages changed: " + messages
      Notify.changeCount(Meteor.user(), -1*messages)