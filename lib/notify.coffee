exports = this
exports.Notify = 
  changeCount: (inc) ->
    unless inc == 0
      Meteor.call 'changeCount', inc, (error, id)->
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
    Meteor.clearInterval Session.get('intervalId')
    
    unless Meteor.user().notifications[0].isTitleFlashing == toggle
      Meteor.call 'toggleTitleFlashing', toggle, (error, toggle)->
        return console.log(error.reason) if error
        Notify.flashTitle toggle
    else 
      @flashTitle toggle

  flashTitle: (toggle) ->
    title = @defaultTitle()
    
    # if toggling flash on, then create interval flashing, else make it static
    if toggle 
      intervalId = 
        Meteor.setInterval () -> 
            newTitle = "New private message..."
            document.title = 
              if document.title == newTitle then Notify.defaultTitle() else newTitle
          , 2500
      Session.set('intervalId', intervalId) 
  
    else 
      document.title = title

  defaultTitle: ->
    # Removed unread count until we can get it working
    # notCount = Meteor.user()?.notifications?[0].count
    # if notCount > 0 then "Strange (" + notCount + " unread)" else "Strange"
    "Strange"

  popup: (divId, alertCopy, darken) ->
    if darken
      Session.set('darken', true)
      $('#main-body').height($(window).height() - 91)

    closeAlert = -> 
      $(divId).addClass "closed"
      Session.set('darken', false) if darken
    
    activateAlert = ->
      $(divId).removeClass "closed"
      $(divId).text(alertCopy)
      Meteor.setTimeout(closeAlert, 2250)

    Meteor.setTimeout(activateAlert, 250)

  # Toggles whether a user is checked into a thread
  toggleCheckIn: (threadId, toggle, userIndex, isMuted) ->
    thread = Threads.findOne(threadId)
    index = userIndex || @userIndex(threadId)
    updateMute = isMuted? && thread?.participants[index].isMuted != isMuted
    updateCheckIn = thread?.participants[index].isInThread != toggle

    if thread? && (updateMute || updateCheckIn)

      threadAttr =
        threadId: threadId
        toggle: toggle
        userIndex: index

      threadAttr['isMuted'] = isMuted if isMuted?

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

      if Meteor.user().status.online
        # Show a popup unless the user is in a thread
        @popup('#newMessageAlert') unless isInThread

        # If the user's online, always play sound and toggle title
        @playSound '/waterdrop'
        @toggleTitleFlashing true


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

  cLog: (desc, x) ->
    console.log desc + ":"
    console.log x

  toggleIsMuted: (toggle, msgBody, threadId, userIndex) ->
    Notify.toggleCheckIn(threadId, !toggle, userIndex, toggle)
    
    messageAttr = 
      body: msgBody
      threadId: threadId
      hasExited: true

    Meteor.call 'createMessage', messageAttr, (error, id) -> 
      console.log(error.reason)  if error

    tracking = if toggle then "exited" else "entered"
    mixpanel.track "Note: #{tracking}" if Meteor.isClient

  toggleBlock: (toggle, threadId, userIndex) ->
    blockedIndex = if userIndex == 1 then 0 else 1
    blockedId = Threads.findOne(threadId).participants[blockedIndex].userId
    
    Meteor.call 'toggleBlockUser', toggle, blockedId, (err, id) ->
      console.log err if err

    # Track that user was blocked/unblocked
    if Meteor.isClient
      tracking = if toggle then "blocked" else "unblocked"
      mixpanel.track("Block user: #{tracking}", {
        threadId: @threadId 
        blockerId: Meteor.userId()
        blockedId: blockedId
      })

    # User exits/re-enters all threads with the blocked user
    msgBody = if toggle then "left the chat" else "entered the chat"

    threads = 
      Threads.find
        participants:
          $elemMatch:
            userId: 
              $in: [@userId, blockedId]

    threads.forEach (thread) ->
      Notify.toggleIsMuted(toggle, msgBody, thread._id)
      Meteor.call 'toggleNotificationBlocked', toggle, thread._id, (err) ->
        console.log err if err

  getUserStatus: (userId, avatar, isIdle) ->
    if userId
      user = Meteor.users.findOne userId

      if user
        if (avatar && isIdle) || (!avatar && !isIdle)
          userStatus =
            avatar: user.profile.avatar
            isOnline: user.status?.online && !user.status?.idle 

          Session.set 'avatar', userStatus.avatar
          Session.set 'isOnline', userStatus.isOnline
          
          userStatus
        else if avatar
          user.profile.avatar
        else 
          user.status?.online && !user.status?.idle 

      else
        Meteor.call 'getUserAttr', userId, (err, userAttr) ->
          console.log err if err

          Session.set 'avatar', userAttr.avatar
          Session.set 'isOnline', !userAttr.isIdle

        if (avatar && isIdle) || (!avatar && !isIdle)
          return(
            avatar: Session.get 'avatar'
            isOnline: Session.get 'isOnline'
          )
        else if avatar
          console.log Session.get 'avatar'
          Session.get 'avatar'
        else
          Session.get 'isOnline'
