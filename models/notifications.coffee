exports = this
exports.Notifications = new Meteor.Collection('notifications')

activate = (notification, user) ->
  unless notification.lastSenderId == user._id || !notification
    Notify.playSound(user, '/waterdrop')
    Notify.toggleTitleFlashing(user, true)
    Notify.popup() # can I pass notification into popup?
    Notify.changeCount(user, 1)
    Notify.toggleNavHighlight(user, true)
    Notify.toggleItemHighlight(notification, true)

userId = if Meteor.isClient then Meteor.userId() else @userId
Notifications.find(
    userId: userId
  , 
    fields: 
      _id: 1
      updatedAt: 1
).observe(
  changed: (oldNotification, newNotification) ->
    userId = if Meteor.isClient then Meteor.userId() else @userId
    user = Meteor.users.findOne(userId)
    notification = Notifications.findOne(newNotification._id)
    Meteor.clearInterval
    activate(notification, user)
)

Meteor.methods
  createNotification: (messageAttributes) ->
    if Meteor.isServer 
      if messageAttributes.noteId
        thread = Threads.findOne(noteId: messageAttributes.noteId)
        messageAttributes['threadId'] = thread._id
      else
        thread = Threads.findOne(messageAttributes.threadId)
      
      now
      notification

      # create a notification for each participant in the conversation
      for participant in thread.participants
        now = new Date().getTime()

        notification = _.extend(_.pick(messageAttributes, 'threadId', 'lastMessage'),
            userId: participant.userId
            lastSenderId: Meteor.userId()
            isNotified: false
            createdAt: now
            updatedAt: now
          )

        if Notifications.findOne(_.pick(messageAttributes, 'threadId')) == undefined || participant.userId != Meteor.userId()
          notification['lastAvatar'] = Meteor.user().profile['avatar']

        Notifications.upsert(
            threadId: messageAttributes.threadId
            userId: participant.userId
          , 
            $set: notification
          )

  toggleItemHighlight: (notAttr) ->
    notId = notAttr._id
    notUpdate = _.extend(_.pick(notAttr, 'isNotified'))
    Notifications.update(
        notId
      ,
        $set: notUpdate
    )