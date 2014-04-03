exports = this
exports.Messages = new Meteor.Collection('messages')

Meteor.methods
  createMessage: (messageAttributes) ->
    user = Meteor.user()

    if !user
      throw new Meteor.Error(401, "You have to login to create a message.")

    if !messageAttributes.body
      throw new Meteor.Error(422, 'Woops, looks like your message is blank!')
    
    # special call for replies
    if messageAttributes.noteId && Meteor.isServer
      messageAttributes.threadId = 
        Threads.findOne(noteId: messageAttributes.noteId)._id

    if messageAttributes.threadId
      # whitelisted keys
      now = new Date().getTime()
      message = _.extend(_.pick(messageAttributes, 'threadId', 'body'),
        senderId: user._id
        createdAt: now
        updatedAt: now
        isRead: false
      )

      message._id = Messages.insert(message)

      # createMessageNotification(message)
      message._id


  updateRead: (messageAttributes) ->
    user = Meteor.user()

    if !user
      throw new Meteor.Error(401, "You have to login to update a message.")
      
    # whitelisted keys
    now = new Date().getTime()
    message = _.extend(_.pick(messageAttributes, 'isRead'),
      updatedAt: now
    )

    Messages.update(messageAttributes.messageId, $set: message)