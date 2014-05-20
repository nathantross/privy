Template.notification.helpers
  messageIntro: ->
    message = @lastMessage
    previewLength = 20 # change this to update number of characters
    if previewLength < message.length
      message = message.slice(0, previewLength) + "..."
    message

Template.notification.events
  'click .archive': (e)->
    e.preventDefault()
    Meteor.call "toggleArchived", @_id, true, (err, notId)->
      console.log err if err       
