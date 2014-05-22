Template.notification.helpers
  messageIntro: ->
    previewLength = 20 # change this to update number of characters
    if previewLength < @lastMessage.length
      @lastMessage.slice(0, previewLength) + "..."
    else
      @lastMessage

  notifiedStyle: ->
    if @isNotified then "pull-right fa fa-circle" else ""

  sender: ->
    user = Meteor.users.findOne @lastAvatarId
    isOnline =
      if user.status?.online && !user.status?.idle && user._id != Meteor.userId() then "•" else ""

    return(
      avatar: user.profile.avatar
      isOnline: isOnline
    )
    

Template.notification.events
  'click .archive': (e)->
    e.preventDefault()
    Meteor.call "toggleArchived", @_id, true, (err, notId)->
      console.log err if err       
