exports = this
exports.Messages = new Meteor.Collection('messages')

Meteor.methods
  createMessage: (messageAttributes) ->
    user = Meteor.user()

    if !user
      throw new Meteor.Error(401, "You have to login to create a message.")

    if !messageAttributes.body
      throw new Meteor.Error(422, 'Woops, looks like your message is blank!')
      
    # whitelisted keys
    now = new Date().getTime()
    message = _.extend(_.pick(messageAttributes, 'threadId', 'body'),
      senderId: user._id
      createdAt: now
      updatedAt: now
      isRead: false
    )

    Messages.insert(message)