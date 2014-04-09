Template.notification.helpers
  messageIntro: ->
    message = @lastMessage
    previewLength = 20 # change this to update number of characters
    if previewLength < message.length
      message = message.slice(0, previewLength) + "..."
    message
     

Template.notification.events
  'click a': ->
    if @isNotified
      Meteor.call('notified', @_id, (error, id) ->
        alert(error.reason) if error
      )
    Router.go('showThread', _id: @threadId)