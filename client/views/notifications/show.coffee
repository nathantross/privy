Template.notification.helpers
  messageIntro: ->
    message = @lastMessage
    previewLength = 20 # change this to update number of characters
    if previewLength < message.length
      message = message.slice(0, previewLength) + "..."
    message
