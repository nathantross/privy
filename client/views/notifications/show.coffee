Template.notification.helpers
  lastMessagePreview: ->
    textPreview @lastMessage, 20 if @lastMessage

  originalNotePreview: -> 
    textPreview @originalNote, 20 if @originalNote

  notifiedStyle: ->
    if @isNotified then "pull-right fa fa-circle" else ""

  sender: ->
    if @lastAvatarId
      userAttr = Notify.getUserStatus @lastAvatarId

      isOnline = 
        if userAttr.isOnline && @lastAvatarId != Meteor.userId() then "•" else ""

      return(
        avatar: userAttr.avatar
        isOnline: isOnline
      )

  textPreview = (message, previewLength) ->
    if previewLength < message.length
      message.slice(0, previewLength) + "..."
    else
      message
    

Template.notification.events
  'click .archive': (e)->
    e.preventDefault()
    Meteor.call "toggleArchived", @_id, true, (err, notId)->
      console.log err if err  
    mixpanel.track "Notification: archived"

  'click .notification-link': ->
    mixpanel.track "Notification: clicked"    
