exports = this
exports.Messages = new Meteor.Collection('messages')

Meteor.methods
  createMessage: (msgAttr) ->
    participants = Notify.getParticipants(msgAttr.threadId)

    #Validations
    unless msgAttr.body
      throw new Meteor.Error(422, 'Woops, looks like your message is blank!')

    if Meteor.isServer && !_.findWhere(participants, {userId: @userId})
      throw new Meteor.Error 401, "You can't create messages on this thread."

    # Set isRead
    isRead = msgAttr.hasExited?
    
    if !isRead && (participants || Meteor.isServer)
      for participant in participants
        if participant.userId != @userId && participant.isInThread
          isRead = true
    
    # Set message attributes
    now = new Date().getTime()
    message = _.extend(_.pick(msgAttr, 'threadId', 'body'),
      senderId: @userId
      createdAt: now
      isRead: isRead 
    )    
    
    # Check to see if this is a special type of message
    if msgAttr.hasExited? 
      unless typeof msgAttr.hasExited == "boolean"
        throw new Meteor.Error(400, "hasExited must be set to true or false.")
      
      message.hasExited = msgAttr.hasExited 

    if msgAttr.isPoint?
      unless typeof msgAttr.isPoint == "boolean"
        throw new Meteor.Error(400, "isPoint must be set to true or false.")
      
      message.isPoint = msgAttr.isPoint 

    # Insert the messages
    msgId = Messages.insert(message)

    # Send Mixpanel event
    if Meteor.isClient
      mixpanel.track("Message: created", {
        threadId: msgAttr.threadId
        userId: @userId
      })

    msgId

  readMessage: (threadId) -> 
    @unblock()
    index = Notify.userIndex(threadId)
    
    unless Threads.findOne(threadId)?.participants[index].userId == @userId || !Meteor.isServer
      throw new Meteor.Error(401, "You can't read messages on this thread.")

    # whitelisted keys
    now = new Date().getTime()
    Messages.update
        threadId: threadId
        senderId: 
          $ne: @userId
        isRead: false
      , 
        $set:
          isRead: true
          updatedAt: now
      ,
        multi: true
        
    # Decrement the notification count by the messages read
    # Notify.changeCount(-1*messages) unless messages == 0