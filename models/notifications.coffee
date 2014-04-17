exports = this
exports.Notifications = new Meteor.Collection('notifications')

# These methods modify the database
Meteor.methods
  createNotification: (messageAttributes) -> 
    user = Meteor.user()

    if messageAttributes.noteId
      thread = Threads.findOne(noteId: messageAttributes.noteId)
      messageAttributes['threadId'] = thread._id
    else
      thread = Threads.findOne(messageAttributes.threadId)

    # Declare errors
    unless thread
        throw new Meteor.Error(404, "This thread doesn't exist.")

    unless user
        throw new Meteor.Error(401, "You have to login to create a notification.")

    unless Notify.isInThread(user._id, thread._id) 
        throw new Meteor.Error(401, "You cannot perform this action on this thread.")

    if messageAttributes.lastMessage == ""
        throw new Meteor.Error(404, "Woops, looks like your message is blank!")

    if Meteor.isServer
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

        # Insert the notifications for each participant
        notId = Notifications.upsert(
            threadId: messageAttributes.threadId
            userId: participant.userId
          , 
            $set: notification
          ).insertedId

        fullParticipant = Meteor.users.find(participant.id)
        
        unless user.status.online
          Meteor.users.update(participant.userId,
            $set: 
              updatedAt: now
            $inc: 
              'notifications.0.count': 1
          )

          # Turn on the nav notification
          unless participant.notifications[0].isNavNotified
            Meteor.users.update(
                participant.userId
              ,
                $set:
                  'notifications.0.isNavNotified': true
                  updatedAt: now
            )

          # Highlight the item in the nav
          Notifications.update(
              notId
            ,
              $set: 
                isNotified: true
                updatedAt: now
          )


  toggleItemHighlight: (notAttr) ->
    user = Meteor.user()
    notId = notAttr._id
    notification = Notifications.findOne(notId)

    unless notification
        throw new Meteor.Error(404, "This notification doesn't exist.")

    unless user
        throw new Meteor.Error(401, "You have to login to create a notification.")

    if notification.userId != user._id
      throw new Meteor.Error(401, "You cannot access this notification.")

    notUpdate = _.extend(_.pick(notAttr, 'isNotified'))
    Notifications.update(
        notId
      ,
        $set: notUpdate
    )