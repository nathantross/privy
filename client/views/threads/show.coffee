Template.showThread.events
  
  'click .load-more': (e)->
    e.preventDefault()
    Session.set('bodyScrollTop', $('body').scrollTop())
    Session.set('msgWrapHeight', $('#msg-wrap').height())
    Router.go(@nextPath)

  'click #leave-chat': (e) ->
    toggleIsMuted(true, "left the chat", @threadId, @userIndex)

  'click #enter-chat': (e) ->
    toggleIsMuted(false, "entered the chat", @threadId, @userIndex)


  toggleIsMuted = (toggle, msgBody, threadId, userIndex) ->
    Notify.toggleCheckIn(threadId, !toggle, userIndex, toggle)
    
    messageAttr = 
      body: msgBody
      threadId: threadId
      hasExited: true

    Meteor.call 'createMessage', messageAttr, (error, id) -> 
      console.log(error.reason)  if error

    tracking = if toggle then "exited" else "entered"
    Mixpanel.track "Note: #{tracking}"


Template.showThread.helpers
  isMuted: ->
    Threads.findOne(@threadId)?.participants[@userIndex].isMuted
