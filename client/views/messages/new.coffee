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
    toggleTyping(@threadId, @userIndex, false)
    $('body').scrollTop($("#messages")[0].scrollHeight)
    $body.val("") 
    # Email Notification
    Meteor.call "sendNotificationEmail", (err) ->
      console.log err  if err
      

  "keydown input": (e) ->
    $body = $(e.target).find('[name=message-body]')
    body = $body.context.value
    toggleTyping(@threadId, @userIndex, true) if body.length == 1

  "keyup input": (e) ->
    $body = $(e.target).find('[name=message-body]')
    body = $body.context.value
    toggleTyping(@threadId, @userIndex, false) if body.length == 0

  "click input": (e) ->
    Notify.toggleTitleFlashing(false)


  toggleTyping = (threadId, userIndex, toggle) ->
    unless Threads.findOne(threadId).participants[userIndex].isTyping == toggle
      threadAttr = 
        threadId: threadId
        toggle: toggle
        userIndex: userIndex

      Meteor.call('toggleIsTyping', threadAttr, (error, id) -> 
          alert(error.reason) if error 
        )

