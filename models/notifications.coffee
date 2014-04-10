exports = this
exports.Notifications = new Meteor.Collection('notifications')

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
    console.log notification
    activate(notification, user)

  playSound = (filename) ->
    document.getElementById("sound").innerHTML = "<audio autoplay=\"autoplay\"><source src=\"" + filename + ".mp3\" type=\"audio/mpeg\" /><source src=\"" + filename + ".ogg\" type=\"audio/ogg\" /><embed hidden=\"true\" autostart=\"true\" loop=\"false\" src=\"" + filename + ".mp3\" /></audio><!-- \"Waterdrop\" by Porphyr (freesound.org/people/Porphyr) / CC BY 3.0 (creativecommons.org/licenses/by/3.0) -->"

  toggleNavHighlight = (user, toggle)->
    unless user.notifications[0].isNavNotified == toggle
      userAttr = 
        _id: user._id
        'notifications.0.isNavNotified': toggle
      Meteor.call('toggleNavHighlight', userAttr, (error, id)->
        alert(error.reason) if error
      )

  toggleItemHighlight = (notification, toggle) ->
    unless notification.isNotified == toggle
      notAttr = 
        _id: notification._id
        isNotified: toggle
      Meteor.call('toggleItemHighlight', notAttr, (error, id)->
        alert(error.reason) if error
      )

  changeCount = (user, inc) ->
    userAttr = 
      _id: user._id
      'notifications.0.count': inc
    Meteor.call('changeCount', userAttr, (error, id)->
      alert(error.reason) if error
    )

  toggleTitleFlashing = (user, toggle) ->
    unless user.notifications[0].isTitleFlashing == toggle
      userAttr =
        _id: user._id
        'notifications.0.isTitleFlashing': toggle
      Meteor.call('toggleTitleFlashing', userAttr, (error, id)->
        alert(error.reason) if error
      )

  titleLogic = (title) ->
    newTitle = "New private message..."
    document.title = if document.title == newTitle then title else newTitle

  flashTitle = (user)->
    if user.notifications[0].isTitleFlashing
      notCount = user.notifications[0].count
      title = 
        if notCount > 0 then "Privy (" + notCount + " unread)" else "Privy"
      Meteor.setInterval( () -> 
          titleLogic(title)
        , 2500)
    else
      Meteor.clearInterval

  popup = ->
    $("#popup").slideDown "slow", ->
      Meteor.setTimeout(()-> 
          $("#popup").slideUp("slow")
        , 3000)

  slideUp = ->
    $("#popup").slideUp("slow")

  activate = (notification, user) ->
    unless notification.lastSenderId == user._id || !notification
      playSound('/waterdrop')
      toggleTitleFlashing(user, true)
      flashTitle(user)
      popup() # can I pass notification into popup?
      changeCount(user, 1)
      toggleNavHighlight(user, true)
      toggleItemHighlight(notification, true)
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