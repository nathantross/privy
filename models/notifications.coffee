exports = this
exports.Notifications = new Meteor.Collection('notifications')

# Start monitoring whether a user is idle
Meteor.startup ->
  if Meteor.isClient
    Deps.autorun ->
      try
        UserStatus.startMonitor
          threshold: 10000 # Time until user is idle
          interval: 5000
        @pause()
        
# These methods modify the database
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