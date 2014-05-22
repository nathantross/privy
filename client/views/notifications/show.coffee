Template.notification.helpers
  lastMessagePreview: ->
    textPreview @lastMessage, 20 if @lastMessage

  originalNotePreview: -> 
    textPreview @originalNote, 20 if @originalNote

  notifiedStyle: ->
    if @isNotified then "pull-right fa fa-circle" else ""

  sender: ->
    user = Meteor.users.findOne @lastAvatarId if @lastAvatarId

    if user
      isOnline =
        if user.status?.online && !user.status?.idle && user._id != Meteor.userId() then "•" else ""

      return(
        avatar: user.profile.avatar
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
