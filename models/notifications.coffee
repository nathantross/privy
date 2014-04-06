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

        # if participant is not the sender, set avatar to sender's avatar
        # and notify the participant.
        unless participant.userId == Meteor.userId()
          notification = _.extend(_.pick(messageAttributes, 'threadId', 'lastMessage'),
            userId: participant.userId
            lastAvatar: Meteor.user().profile['avatar']
            isNotified: true
            createdAt: now
            updatedAt: now
          )
        # if participant is the sender, don't touch the avatar
        # also, don't notify the sender
        else
          notification = _.extend(_.pick(messageAttributes, 'threadId', 'lastMessage'),
            userId: participant.userId
            isNotified: false
            createdAt: now
            updatedAt: now
          )

        # create the notification
        notId = Notifications.upsert(
            threadId: messageAttributes.threadId
            userId: participant.userId
          , 
            $set: notification
          ).insertedId
        
        # If notification doesn't have an avatar yet, set it to sender's avatar
        unless Notifications.findOne(notId) == undefined || Notifications.findOne(notId).lastAvatar
          Notifications.update notId,
            $set:
              lastAvatar: Meteor.user().profile['avatar']

        # Notify all participants, except the sender
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
