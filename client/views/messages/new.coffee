Template.newMessage.events
  "submit form": (e, template) ->
    e.preventDefault()

    $body = $(e.target).find('[name=message-body]')
    message = 
      body: $body.val()
      threadId: template.data._id

    Meteor.call('deliver', message, (error, messageId) ->
      alert(error.reason) if error # need better error handling
    )