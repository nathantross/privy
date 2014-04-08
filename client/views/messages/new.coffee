Template.newMessage.events
  "submit form": (e) ->
    e.preventDefault()

    $body = $(e.target).find('[name=message-body]')
    message = 
      body: $body.val()
      threadId: @threadId
      lastMessage: $body.val()

    Meteor.call('createMessage', message, (error, id) -> 
      if error
        alert(error.reason) 
      else
        Meteor.call('createNotification', message, (error, id) ->
          alert(error.reason) if error 
        )
    )

    Meteor.call('endTyping', @threadId, (error, id) -> 
        alert(error.reason) if error 
      )

    $body.val("") 

  "keyup input": (e) ->
    $body = $(e.target).find('[name=message-body]')
    inputText = $body.context.value
    if inputText.length == 1
      Meteor.call('startTyping', @threadId, (error, id) -> 
        alert(error.reason) if error 
      )

    if inputText.length == 0
      Meteor.call('endTyping', @threadId, (error, id) -> 
        alert(error.reason) if error 
      )