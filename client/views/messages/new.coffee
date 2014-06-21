Template.newMessage.events

  "submit form": (e) ->
    e.preventDefault()

    $body = $(e.target).find('[name=message-body]')
    message = 
      body: $body.val()
      threadId: @threadId
      lastMessage: $body.val()

    Meteor.call 'createMessage', message, (error, id) -> 
      if error
        console.log(error.reason) 
      else
        Meteor.call 'createNotification', message, (error, id) ->
          console.log(error.reason) if error 
    
    toggleTyping(@threadId, @userIndex, false)
    $('body').scrollTop($("#messages")[0].scrollHeight)
    $body.val("") 
    

  "keydown input": (e) ->
    $body = $(e.target).find('[name=message-body]')
    body = $body.context.value
    if body.length == 1
      toggleTyping(@threadId, @userIndex, true) 


  "keyup input": (e) ->
    $body = $(e.target).find('[name=message-body]')
    body = $body.context.value
    if body.length == 0
      toggleTyping(@threadId, @userIndex, false) 


  "click input": (e) ->
    Notify.toggleTitleFlashing(false)


  toggleTyping = (threadId, userIndex, toggle) ->
    participants = Notify.getParticipants(threadId)
    unless participants[userIndex].isTyping == toggle
      threadAttr = 
        threadId: threadId
        toggle: toggle
        userIndex: userIndex

      Meteor.call 'toggleIsTyping', threadAttr, (error, id) -> 
          console.log(error.reason) if error 
  
