exports = this
exports.Notify = 
  changeCount: (user, inc) ->
    userAttr = 
      _id: user._id
      'notifications.0.count': inc
    Meteor.call('changeCount', userAttr, (error, id)->
      alert(error.reason) if error
    )

  playSound: (user, filename) ->
    if user.notifications[0].sound
      document.getElementById("sound").innerHTML = "<audio autoplay=\"autoplay\"><source src=\"" + filename + ".mp3\" type=\"audio/mpeg\" /><source src=\"" + filename + ".ogg\" type=\"audio/ogg\" /><embed hidden=\"true\" autostart=\"true\" loop=\"false\" src=\"" + filename + ".mp3\" /></audio><!-- \"Waterdrop\" by Porphyr (freesound.org/people/Porphyr) / CC BY 3.0 (creativecommons.org/licenses/by/3.0) -->"

  toggleNavHighlight: (user, toggle)->
    unless user.notifications[0].isNavNotified == toggle
      userAttr = 
        _id: user._id
        'notifications.0.isNavNotified': toggle
      Meteor.call('toggleNavHighlight', userAttr, (error, id)->
        alert(error.reason) if error
      )

  toggleItemHighlight: (notification, toggle) ->
    unless notification.isNotified == toggle
      notAttr = 
        _id: notification._id
        isNotified: toggle
      Meteor.call('toggleItemHighlight', notAttr, (error, id)->
        alert(error.reason) if error
      )

  toggleTitleFlashing: (user, toggle) ->
    Meteor.clearInterval(Session.get('intervalId'))
    unless user.notifications[0].isTitleFlashing == toggle
      userAttr =
        _id: user._id
        'notifications.0.isTitleFlashing': toggle
      Meteor.call('toggleTitleFlashing', userAttr, (error, id)->
        alert(error.reason) if error
      )

    if toggle
      intervalId = @flashTitle(user)
      Session.set('intervalId', intervalId)
    else
      notCount = user.notifications[0].count
      document.title = 
        if notCount > 0 then "Privy (" + notCount + " unread)" else "Privy"

  flashTitle: (user)->
    if user.notifications[0].isTitleFlashing
      notCount = user.notifications[0].count
      title = 
        if notCount > 0 then "Privy (" + notCount + " unread)" else "Privy"
      
      Meteor.setInterval( () -> 
          newTitle = "New private message..."
          document.title = 
            if document.title == newTitle then title else newTitle
        , 2500)

  popup: ->
    $("#popup").slideDown "slow", ->
      Meteor.setTimeout(()-> 
          $("#popup").slideUp("slow")
        , 3000)

  # This logic determines how to display notifications
  activate: (notification, user) ->
    if notification.lastSenderId != user._id && notification?
      console.log "Activate function: Firing"
      # Determine if user is in the notification's thread
      isInThread = false
      thread = Threads.findOne(notification.threadId)
      for participant in thread.participants
        if participant.userId == Meteor.userId() 
          isInThread = participant.isInThread

      # Notification depends on whether user is online, idle, 
      # in the notification's thread, or not in the thread
      unless user.status.online
        @changeCount(user, 1)
        @toggleNavHighlight(user, true)
        @toggleItemHighlight(notification, true)
      else if isInThread
        @playSound(user, '/waterdrop')
        @toggleTitleFlashing(user, true)
      else 
        @playSound(user, '/waterdrop')
        @popup() # can I pass notifica/tion into popup?
        @changeCount(user, 1)
        @toggleNavHighlight(user, true)
        @toggleItemHighlight(notification, true)
        if user.status.idle
          @toggleTitleFlashing(user, true)

  trackChanges: ->
    userId = if Meteor.isClient then Meteor.userId() else @userId
    console.log userId if userId
    if userId
      console.log "track chages firing!"
      Notifications.find(
            userId: userId
          , 
            fields: 
              _id: 1
              updatedAt: 1
        ).observe(
          changed: (oldNotification, newNotification) ->
            console.log "observe function: Firing"
            userId = if Meteor.isClient then Meteor.userId() else @userId
            user = Meteor.users.findOne(userId)
            notification = Notifications.findOne(newNotification._id)
            Notify.activate(notification, user)
        )