exports = this
exports.Notifications = new Meteor.Collection('notifications')

# These methods modify the database
Meteor.methods
  createNotification: (messageAttr) -> 
    user = Meteor.user()
    threadId = messageAttr.threadId

    # Declare errors
    unless user
      throw new Meteor.Error 401, "Please login to create a notification."

    unless Notify.isParticipant(user._id, threadId) 
      throw new Meteor.Error 401, "You can't create notifications in this thread."

    if messageAttr.lastMessage == ""
      throw new Meteor.Error 404, "Whoops, looks like your message is blank!"

    unless threadId
        throw new Meteor.Error 404, "ThreadId doesn't exist to make this notification."
  
    # Create a notification for the current user
    now = new Date().getTime()
    notification = _.extend(_.pick(messageAttr, 'threadId', 'lastMessage'),
      userId: user._id
      lastSenderId: user._id
      isNotified: false
      createdAt: now
      updatedAt: now
    )

    # set avatar if replying to a note
    if messageAttr.avatar 
      notification['lastAvatar'] = messageAttr.avatar
    
    # set avatar if creating a note
    else if Notifications.findOne(_.pick(messageAttr, 'threadId')) == undefined
       notification['lastAvatar'] = user.profile['avatar']

    # create the notification
    Notifications.upsert
        threadId: threadId
        userId: user._id
      , 
        $set: notification         

    # Create a notification for each of the other users
    if Meteor.isServer
      thread = Threads.findOne(threadId)

      unless thread
        throw new Meteor.Error 404, "Thread doesn't exist to make this notification."
      
      # create a notification for each participant (pUser) in the thread
      pUser
      for participant in thread.participants
        unless participant.userId == user._id
          pUser = Meteor.users.findOne participant.userId
          notification['userId'] = pUser._id
          notification['isNotified'] = !pUser.status?.online || pUser.status?.idle
          notification['lastAvatar'] = user.profile['avatar']

          # Insert the notifications for each participant
          Notifications.upsert
              threadId: messageAttr.threadId
              userId: pUser._id
            , 
              $set: notification
          
          if !pUser.status?.online
            # Put a notification on the nav if they're offline or idle
            Meteor.users.update pUser._id,
              $set: 
                'notifications.0.isNavNotified': true
                updatedAt: now
              $inc: 
                'notifications.0.count': 1
          
          if !pUser.status?.online || pUser.status?.idle
            # Send notification email to offline user
            emailAttr = 
              receiverEmail: pUser.emails[0].address
              senderAvatar: user.profile.avatar
              threadId: threadId
              lastMessage: messageAttr.lastMessage

            Email.send
              from: "Privy <hello@privy.cc>"
              to: emailAttr.receiverEmail
              subject: "You have a new message"
              text: "You have a new message at https://privy.cc"
              html: "<center>You have a new message from <img src='http://localhost:3000/" + emailAttr.senderAvatar + "' /><br><br>" + emailAttr.lastMessage + "<br><br><a href='localhost:3000/" + emailAttr.threadId + "' >Click here to respond</a></center>"


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