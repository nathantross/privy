exports = this
exports.Notifications = new Meteor.Collection('notifications')

# These methods modify the database
Meteor.methods
  createNotification: (messageAttr) -> 
    threadId = messageAttr.threadId

    # Declare errors
    if messageAttr.lastMessage == ""
      throw new Meteor.Error 404, "Whoops, looks like your message is blank!"

    if messageAttr.originalNote == ""
      throw new Meteor.Error 404, "Whoops, looks like your original note is blank!"

    # Server validations
    if Meteor.isServer
      participants = Notify.getParticipants(threadId)
      userIsInThread = _.findWhere(participants, {userId: @userId})
      unless userIsInThread
        throw new Meteor.Error 401, "You can't create notifications in this thread."

      if messageAttr.noteCreatorId && !userIsInThread
        throw new Meteor.Error 401, "This senderId is invalid"

  
    # Create a notification for the current user
    now = new Date().getTime()
    notification = _.extend(_.pick(messageAttr, 'threadId', 'lastMessage'),
      userId: @userId
      lastSenderId: @userId
      isNotified: false
      isArchived: false
      createdAt: now
      updatedAt: now
    )

    # set avatar if replying to a note
    if messageAttr.isReply
      notification['lastAvatarId'] = messageAttr.noteCreatorId
      notification['originalNote'] = messageAttr.originalNote
    
    # set avatar if creating a note
    else if messageAttr.isNewNote
      notification['lastAvatarId'] = @userId
      notification['originalNote'] = messageAttr.lastMessage

    # create the notification
    Notifications.upsert
        threadId: threadId
        userId: @userId
      , 
        $set: notification         

    # Create a notification for each of the other users
    @unblock()
    if Meteor.isServer
      # create a notification for each participant (pUser) in the thread
      pUser
      for participant in participants
        unless participant.userId == @userId || participant.isMuted
  
          notification = _.extend notification,
            userId: participant.userId
            isNotified: !participant.isInThread
            lastAvatarId: @userId

          # Insert the notifications for each participant
          Notifications.upsert
              threadId: threadId
              userId: participant.userId
            , 
              $set: notification
          
          # Highlight nav and increment unread count if user's not in thread
          unless participant.isInThread
            Meteor.users.update participant.userId,
              $set: 
                'notifications.0.isNavNotified': true
                updatedAt: now
              $inc: 
                'notifications.0.count': 1
          
          pUser = Meteor.users.findOne participant.userId

          # Send notification email to idle/offline user          
          if pUser.notifications[0].email && (!pUser.status?.online || pUser.status?.idle)

            emailAttr = 
              receiverEmail: pUser.emails[0].address
              senderAvatar: Meteor.user().profile.avatar
              threadId: threadId
              lastMessage: messageAttr.lastMessage

            
            Email.send
              from: "Get Strange <hello@getstrange.co>"
              to: emailAttr.receiverEmail
              subject: "You have a new message"
              text: "You have a new message at http://getstrange.co/threads/" + emailAttr.threadId
              html: "<center><img src='" + emailAttr.senderAvatar + "' /><br><br>You have a new message:<br><br><h1>" + emailAttr.lastMessage + "</h1><br><a href='http://getstrange.co/threads/" + emailAttr.threadId + "' >Click here to respond</a></center>"


  toggleItemHighlight: (notAttr) ->
    user = Meteor.user()
    notId = notAttr._id
    notification = Notifications.findOne(notId)

    unless notification
      throw new Meteor.Error 404, "This notification doesn't exist." 

    unless user
      throw new Meteor.Error 401, "You have to login to create a notification."

    unless notification.userId == @userId
      throw new Meteor.Error 401, "You cannot access this notification."

    notUpdate = _.extend(_.pick(notAttr, 'isNotified'))
    Notifications.update notId,
      $set: notUpdate


  toggleNotificationBlocked: (toggle, threadId) ->
    user = Meteor.user()
    notification = 
      Notifications.findOne 
        userId: user._id
        threadId: threadId

    unless user
      throw new Meteor.Error 401, "You have to login to create a notification."

    unless typeof toggle == "boolean"
      throw new Meteor.Error 401, "Toggle must be a boolean."

    unless notification || Meteor.isClient
      throw new Meteor.Error 404, "Cannot find a matching notification."      

    if notification || Meteor.isServer
      now = new Date().getTime()
      Notifications.update notification._id,
        $set:
          isBlocked: toggle
          updatedAt: now

  toggleArchived: (notId, toggle) ->
    user = Meteor.user()
    notification = 
      Notifications.findOne 
        _id: notId
        userId: user._id

    unless user
      throw new Meteor.Error 401, "You have to login to create a notification."

    unless notification
      throw new Meteor.Error 404, "Cannot find a matching notification."

    unless typeof toggle == "boolean"
      throw new Meteor.Error 401, "Toggle must be a boolean."

    Notifications.update notId,
      $set:
        isArchived: toggle

    mixpanel.track "Notification: archived" if Meteor.isClient
    notId
