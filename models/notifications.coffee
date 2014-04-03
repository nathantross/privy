exports = this
exports.Notifications = new Meteor.Collection('notifications')

Notifications.allow
  update: ownsThread()

exports = this
exports.createMessageNotification = (message) ->
  thread = Threads.findOne(message.threadId)
  
  if thread.creatorId && thread.responderId
    notifiedId = ""
    partnerId = ""
    if message.senderId == thread.creatorId 
      notifiedId = thread.responderId
      partnerId = thread.creatorId
    else 
      notifiedId = thread.creatorId
      partnerId = thread.responderId

    Notifications.upsert threadId: thread._id,
      userId: notifiedId
      
      isNotified: true
      avatar: Meteor.users.findOne().profile.avatar


    unless Meteor.user().profile.isNotified
      Meteor.users.update notifiedId,
        $set:
          "profile.isNotified": true

# Meteor.methods
#   notifyOff: (nId) ->
#     Notifications.update nId,
#       $set: 
#         isNotified: false