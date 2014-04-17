exports = this
exports.Notifications = new Meteor.Collection('notifications')

# These methods modify the database
Meteor.methods
  createNotification: (messageAttr) -> 
    user = Meteor.user()

    if messageAttr.noteId
      thread = Threads.findOne(noteId: messageAttr.noteId)
      messageAttr['threadId'] = thread._id
    else
      thread = Threads.findOne(messageAttr.threadId)

    # Declare errors
    unless thread
        throw new Meteor.Error(404, "This thread doesn't exist.")

    unless user
        throw new Meteor.Error(401, "You have to login to create a notification.")

    unless Notify.isInThread(user._id, thread._id) 
        throw new Meteor.Error(401, "You cannot perform this action on this thread.")

    if messageAttr.lastMessage == ""
        throw new Meteor.Error(404, "Woops, looks like your message is blank!")

    if Meteor.isServer
      # Declaring variables for the for loop
      now
      notification
      pUser
      isNotified

      # create a notification for each participant in the conversation
      for participant in thread.participants
        pUser = Meteor.users.findOne(participant.userId) 
        isNotified = 
          if !pUser.status?.online || pUser.status?.idle then true else false
        now = new Date().getTime()

        notification = _.extend(_.pick(messageAttr, 'threadId', 'lastMessage'),
            userId: pUser._id
            lastSenderId: Meteor.userId()
            isNotified: isNotified
            createdAt: now
            updatedAt: now
          )

        # Set the avatar the current user if it's a new note
        if Notifications.findOne(_.pick(messageAttr, 'threadId')) == undefined || pUser._id != Meteor.userId()
          notification['lastAvatar'] = Meteor.user().profile['avatar']

        # Insert the notifications for each participant
        Notifications.upsert(
            threadId: messageAttr.threadId
            userId: pUser._id
          , 
            $set: notification
          )
        
        if !pUser.status?.online || pUser.status?.idle
          # Put a notification on the nav if they're offline or idle
          Meteor.users.update(
              pUser._id
            ,
              $set: 
                'notifications.0.isNavNotified': true
                updatedAt: now
              $inc: 
                'notifications.0.count': 1
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