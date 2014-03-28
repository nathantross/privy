exports = this
exports.Notifications = new Meteor.Collection('notifications')

# Notifications.allow
#   update: ownsThread()

exports = this
exports.createMessageNotification = (message) ->
  thread = Threads.findOne(message.threadId)
  
  if thread.creatorId && thread.responderId
    notifiedId = 
      if message.senderId == thread.creatorId 
        thread.creatorId
      else 
        thread.responderId 

    Notifications.insert
      userId: notifiedId
      threadId: thread._id
      isNotified: true

    unless Meteor.user().profile.isNotified
      Meteor.users.update notifiedId,
        $set:
          "profile.isNotified": true

# Meteor.methods
#   notifyOff: (nId) ->
#     Notifications.update nId,
#       $set: 
#         isNotified: false