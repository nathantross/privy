exports = this
exports.Notify = 
  changeCount: (user, inc) ->
    console.log "ChangeCount Inc: " + inc
    userAttr = 
      _id: user._id
      'notifications.0.count': inc
    Meteor.call('changeCount', userAttr, (error, id)->
      if error
        alert(error.reason) 
      else
        document.title = Notify.defaultTitle(Meteor.users.findOne(userAttr._id))
    )
    console.log "Completed changeCount"

  playSound: (user, filename) ->
    console.log "Started playSound"
    if user.notifications[0].sound
      document.getElementById("sound").innerHTML = "<audio autoplay=\"autoplay\"><source src=\"" + filename + ".mp3\" type=\"audio/mpeg\" /><source src=\"" + filename + ".ogg\" type=\"audio/ogg\" /><embed hidden=\"true\" autostart=\"true\" loop=\"false\" src=\"" + filename + ".mp3\" /></audio><!-- \"Waterdrop\" by Porphyr (freesound.org/people/Porphyr) / CC BY 3.0 (creativecommons.org/licenses/by/3.0) -->"
    console.log "Completed playSound"

  toggleNavHighlight: (user, toggle)->
    console.log "Started toggleNavHighlight"
    unless user.notifications[0].isNavNotified == toggle
      userAttr = 
        _id: user._id
        'notifications.0.isNavNotified': toggle
      Meteor.call('toggleNavHighlight', userAttr, (error, id)->
        alert(error.reason) if error
      )
    console.log "Completed toggleNavHighlight"

  toggleItemHighlight: (notification, toggle) ->
    console.log "Started toggleItemHighlight"
    unless notification.isNotified == toggle
      notAttr = 
        _id: notification._id
        isNotified: toggle
      Meteor.call('toggleItemHighlight', notAttr, (error, id)->
        alert(error.reason) if error
      )
    console.log "Completed toggleItemHighlight"

  toggleTitleFlashing: (user, toggle) ->
    console.log "Running toggleTitleFlashing"
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
      document.title = @defaultTitle(user)
    console.log "Completed toggleTitleFlashing"

  flashTitle: (user)->
    console.log "Running flashTitle"
    if user.notifications[0].isTitleFlashing
      title = @defaultTitle(user)
      Meteor.setInterval( () -> 
          newTitle = "New private message..."
          document.title = 
            if document.title == newTitle then title else newTitle
        , 2500)
    console.log "Completed flashTitle"

  popup: ->
    console.log "Started popup"
    $("#popup").slideDown "slow", ->
      Meteor.setTimeout(()-> 
          $("#popup").slideUp("slow")
        , 3000)
    console.log "Completed popup"

  # This logic determines how to display notifications
  activate: (notification, user) ->
    console.log "Running activate"
    if notification.lastSenderId != user._id && notification?
      # Determine if user is in the notification's thread
      isInThread = @isInThread(Meteor.userId(), notification.threadId)

      # Notification depends on whether user is online, idle, 
      # in the notification's thread, or not in the thread
      if user.status.online
        @playSound(user, '/waterdrop')
        @toggleTitleFlashing(user, true)
        
        unless isInThread 
          @popup() # can I pass notifica/tion into popup?
          @changeCount(user, 1)
          @toggleNavHighlight(user, true)
          @toggleItemHighlight(notification, true)
    console.log "Completed activate"

  trackChanges: ->
    userId = if Meteor.isClient then Meteor.userId() else @userId
    if userId
      Notifications.find(
            userId: userId
          , 
            fields: 
              _id: 1
              updatedAt: 1
        ).observe(
          changed: (oldNotification, newNotification) ->
            console.log "Running trackChanges"
            userId = if Meteor.isClient then Meteor.userId() else @userId
            user = Meteor.users.findOne(userId)
            notification = Notifications.findOne(newNotification._id)
            Notify.activate(notification, user)
            console.log "Completed trackChanges"
        )

  isInThread: (userId, threadId)->
    console.log "Running notify isInThread"
    thread = Threads.findOne(threadId)
    if thread
      for participant in thread.participants
        if participant.userId == userId
          console.log "Completed notify isInThread"
          return participant.isInThread
    false
    console.log "Completed notify isInThread"

  defaultTitle: (user) ->
    console.log "Running defaultTitle"
    notCount = user.notifications[0].count  
    if notCount > 0 then "Privy (" + notCount + " unread)" else "Privy"
    console.log "Completed defaultTitle"