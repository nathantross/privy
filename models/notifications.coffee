exports = this
exports.Notifications = new Meteor.Collection('notifications')

Notifications.allow
  update: ownsThread

createMessageNotification = (message) ->
  thread = Threads.findOne(message.threadId)
  if message.senderId == thread.creatorId && thread.responderId
    Notifications.insert
      userId: thread.responderId
      threadId: thread._id
      isSeen: false
      