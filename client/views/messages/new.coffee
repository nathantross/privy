Template.newMessage.helpers
  hasPoint: ->
    if @participants
      partnerIndex = if @userIndex == 0 then 1 else 0
      if @participants[partnerIndex]?.hasPoint then "disabled" else ""

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

  'click #give-point': (e)->
    e.preventDefault()
    partnerIndex = if @userIndex == 0 then 1 else 0
    userIndex = @userIndex
    participants = @participants

    unless participants[partnerIndex]?.hasPoint || !@threadId
      Meteor.call 'givePoint', @threadId, partnerIndex, @userIndex, (err, threadId) ->
        return console.log err if err
        
        messageAttr = 
          body: "+♥ Great chat!"
          threadId: threadId
          isPoint: true
      
        Meteor.call "createMessage", messageAttr, (err) ->
          return console.log err if err

          Meteor.call 'createNotification', messageAttr, (error, id) ->
            console.log(error.reason) if error 

          mixpanel.track("ThreadNav: gave point", {
            threadId: threadId
            giver: participants[partnerIndex].userId
            receiver: participants[userIndex].userId
          })
          
  # 'click #hasPoint': (e)->
  #   e.preventDefault()
  #   partnerIndex = if @userIndex == 0 then 1 else 0

  #   Meteor.call "toggleHasPoint", @threadId, partnerIndex, (err) ->
  #     console.log err if err 

  toggleTyping = (threadId, userIndex, toggle) ->
    participants = Notify.getParticipants(threadId)
    unless participants[userIndex].isTyping == toggle
      threadAttr = 
        threadId: threadId
        toggle: toggle
        userIndex: userIndex

      Meteor.call 'toggleIsTyping', threadAttr, (error, id) -> 
          console.log(error.reason) if error 
  
