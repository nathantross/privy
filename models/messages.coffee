exports = this
exports.Messages = new Meteor.Collection('messages')

Meteor.methods
  createMessage: (messageAttr) ->
    user = Meteor.user()
    threadId = messageAttr.threadId
    thread = Threads.findOne(threadId)
    index = Notify.userIndex(threadId)

    # special call for replies
    if messageAttr.noteId && Meteor.isServer
      messageAttr.threadId = 
        Threads.findOne(noteId: messageAttr.noteId)._id

    unless user
      throw new Meteor.Error(401, "You have to login to create a message.")

    unless messageAttr.body
      throw new Meteor.Error(422, 'Woops, looks like your message is blank!')
    
    unless messageAttr.threadId
      throw new Meteor.Error(404, "This thread does not exist.")

    unless thread.participants[index].userId == user._id
      throw new Meteor.Error(401, "You can't create messages on this thread.")

    now = new Date().getTime()
    
    # isRead should be true if any of the participants is in the room
    participants = Threads.findOne(messageAttr.threadId).participants
    isRead = false
    for participant in participants
      if participant.userId != user._id && participant.isInThread
        isRead = true

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
    unless messages == 0
      console.log "Messages changed: " + messages
      Notify.changeCount(-1*messages)