exports = this
exports.Notifications = new Meteor.Collection('notifications')

Notifications.allow
  update: ownsThread

exports = this
exports.createMessageNotification = (message) ->
  thread = Threads.findOne(message.threadId)
  
  if thread.creatorId && thread.responderId
    notifiedId = 
      if message.senderId == thread.creatorId 
        thread.responderId 
      else 
        thread.creatorId

    Notifications.insert
      userId: notifiedId
      threadId: thread._id
      isSeen: false
      