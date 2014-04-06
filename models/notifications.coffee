exports = this
exports.Notifications = new Meteor.Collection('notifications')

Meteor.methods
  createNotification: (messageAttributes) ->
    if Meteor.isServer
      thread = Threads.findOne(messageAttributes.threadId)
      
      now
      notification

      # create a notification for each participant in the conversation
      for participant in thread.participants
        now = new Date().getTime()
        unless participant.userId == Meteor.userId()
          notification = _.extend(_.pick(messageAttributes, 'threadId', 'lastMessage'),
            userId: participant.userId
            lastAvatar: Meteor.user().profile['avatar']
            isNotified: true
            createdAt: now
            updatedAt: now
          )
        else
          notification = _.extend(_.pick(messageAttributes, 'threadId', 'lastMessage'),
            userId: participant.userId
            isNotified: false
            createdAt: now
            updatedAt: now
          )

        notId = Notifications.upsert(
            threadId: messageAttributes.threadId
            userId: participant.userId
          , 
            $set: notification
          ).insertedId
        
        unless Notifications.findOne(notId) == undefined || Notifications.findOne(notId).lastAvatar
          Notifications.update notId,
            $set:
              lastAvatar: Meteor.user().profile['avatar']

        user = Meteor.users.findOne(participant.userId)
        unless user.profile.isNotified || user._id == Meteor.userId()
          Meteor.users.update user._id,
            $set:
              "profile.isNotified": true

  notified: (notId) ->
    now = new Date().getTime()
    Notifications.update notId,
        $set:
          isNotified: false
          updatedAt: now
