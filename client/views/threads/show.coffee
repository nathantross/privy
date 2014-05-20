Template.showThread.helpers
  isMuted: ->
    Threads.findOne(@threadId)?.participants[@userIndex].isMuted

Template.showThread.events
  
  'click .load-more': (e)->
    e.preventDefault()
    Session.set('bodyScrollTop', $('body').scrollTop())
    Session.set('msgWrapHeight', $('#msg-wrap').height())
    Router.go(@nextPath)

  'click #leave-chat': (e) ->
    Notify.toggleIsMuted(true, "left the chat", @threadId, @userIndex)

  'click #enter-chat': (e) ->
    Notify.toggleIsMuted(false, "entered the chat", @threadId, @userIndex)

  'click #block-user': (e)->
    Notify.toggleIsMuted(true, "left the chat", @threadId, @userIndex)

    blockedIndex = if @userIndex == 1 then 0 else 1
    blockedId = Threads.findOne(@threadId).participants[blockedIndex].userId
    
    Meteor.call 'toggleBlockUser', true, blockedId (err, id) ->
      console.log err if err
