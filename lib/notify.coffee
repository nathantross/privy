exports = this
exports.Notify = 
  changeCount: (inc) ->
    userAttr = 
      _id: Meteor.userId()
      'notifications.0.count': inc
    Meteor.call 'changeCount', userAttr, (error, id)->
      console.log(error.reason) if error

  playSound: (filename) ->
    if Meteor.user().notifications[0].sound
      document.getElementById("sound").innerHTML = "<audio autoplay=\"autoplay\"><source src=\"" + filename + ".mp3\" type=\"audio/mpeg\" /><source src=\"" + filename + ".ogg\" type=\"audio/ogg\" /><embed hidden=\"true\" autostart=\"true\" loop=\"false\" src=\"" + filename + ".mp3\" /></audio><!-- \"Waterdrop\" by Porphyr (freesound.org/people/Porphyr) / CC BY 3.0 (creativecommons.org/licenses/by/3.0) -->"

  toggleNavHighlight: (toggle)->
    user = Meteor.user()
    unless user.notifications[0].isNavNotified == toggle
      userAttr = 
        _id: user._id
        'notifications.0.isNavNotified': toggle
      Meteor.call 'toggleNavHighlight', userAttr, (error, id) ->
        console.log(error.reason) if error

  toggleItemHighlight: (notification, toggle) ->
    unless notification.isNotified == toggle
      notAttr = 
        _id: notification._id
        isNotified: toggle
      $({})
        .queue((next)->
          Meteor.call 'toggleItemHighlight', notAttr, (error, id) ->
            console.log(error.reason) if error
          next()
        ).queue((next)->
          unless toggle || Notify.anyItemsNotified()
            Notify.toggleNavHighlight(false) 
        )

  # Toggling the title
  toggleTitleFlashing: (toggle) ->
    Meteor.clearInterval(Session.get('intervalId'))
    unless Meteor.user().notifications[0].isTitleFlashing == toggle
      userAttr =
        _id: Meteor.userId()
        'notifications.0.isTitleFlashing': toggle
      $({})
        .queue((next)->
          Meteor.call 'toggleTitleFlashing', userAttr, (error, id)->
            console.log(error.reason) if error
          next()
        )
        .queue((next)->
          Notify.resetTitle(toggle)
          next()
        )
    else 
      @resetTitle(toggle)

  resetTitle: (toggle) ->
    if toggle
      intervalId = @flashTitle()
      Session.set('intervalId', intervalId)
    else
      document.title = @defaultTitle()

  flashTitle: ->
    title = @defaultTitle(Meteor.user())
    Meteor.setInterval( () -> 
        newTitle = "New private message..."
        document.title = 
          if document.title == newTitle then title else newTitle
      , 2500)

  defaultTitle: ->
    notCount = 
      if Meteor.user() && Meteor.user().notifications
        Meteor.user().notifications[0].count
      else
        0
    if notCount > 0 then "Privy (" + notCount + " unread)" else "Privy"

  # Popup activates the popup notification 
  popup: (divId, alertCopy, darken) ->
    if darken
        Session.set('darken', true)
        $('#main-body').height($(window).height() - 91)

    $(divId).slideDown "slow", ->
      Meteor.setTimeout(()-> 
          $(divId).slideUp("slow")
          Session.set('darken', false) if darken
        , 3000)
    $(divId).text(alertCopy)

  # Toggles whether a user is checked into a thread
  toggleCheckIn: (threadId, toggle, userIndex) ->
    thread = Threads.findOne(threadId)
    index = userIndex || @userIndex(threadId)
    if thread && thread.participants[index].isInThread != toggle 
      threadAttr =
        threadId: threadId
        toggle: toggle
        userIndex: index

      Meteor.call 'toggleIsInThread', threadAttr, (error, id) ->
        console.log(error.reason) if error

  # Helper function that determines whether a user is in a thread
  isInThread: (userId, threadId)->
    thread = Threads.findOne(threadId)
    if thread
      for participant in thread.participants
        if participant.userId == userId
          return participant.isInThread
    false

  userIndex: (threadId) ->
    thread = Threads.findOne(threadId)
    if thread
      for participant, i in thread.participants
        if participant.userId == Meteor.userId()
          return i
    false

  isParticipant: (userId, threadId)->
    thread = Threads.findOne(threadId)
    if thread
      for participant in thread.participants
        if participant.userId == userId
          return true
    false

  # This logic determines how to display notifications
  activate: (notification) ->
    if notification? && notification.lastSenderId != Meteor.userId() && Meteor.user()
      # Determine if user is in the notification's thread
      isInThread = @isInThread(Meteor.userId(), notification.threadId)

      # Notification depends on whether user is online, idle, 
      # in the notification's thread, or not in the thread
      if Meteor.user().status.online
        unless isInThread 
          @popup('#newMessageAlert')
          @changeCount(1)
          @toggleNavHighlight(true)
          @toggleItemHighlight(notification, true)

        # If the user's online, always play sound and toggle title
        @playSound('/waterdrop')
        @toggleTitleFlashing(true)

  # trackChanges observes any changes in notifications and activates a response
  trackChanges: ->
    userId = if Meteor.isClient then Meteor.userId() else @userId
    if userId
      startTracking = new Date().getTime()
      Notifications.find(
            userId: userId
          , 
            fields: 
              _id: 1
              updatedAt: 1
        ).observe(
          changed: (oldNotification, newNotification) ->  
            notification = Notifications.findOne(newNotification._id)
            Notify.activate(notification)
          
          added: (newNotification) ->  
            if startTracking < newNotification.updatedAt
              notification = Notifications.findOne(newNotification._id)
              Notify.activate(notification)
        )

  anyItemsNotified: ->
    Notifications.findOne(
      userId: Meteor.user()._id
      isNotified: true
    ) != undefined

  toggleLock: (noteId, isLocked) ->
    if noteId
      note = Notes.findOne(noteId)
      if note && ((note.currentViewer == Meteor.userId() && !isLocked) || (note.currentViewer == undefined && isLocked))
        noteAttr = 
          noteId: noteId
          isLocked: isLocked
        Meteor.call 'toggleLock', noteAttr, (err) ->
          console.log(err) if err   
