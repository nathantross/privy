Template.showThread.helpers
  isMuted: ->
    @participants[@userIndex].isMuted if @participants

Template.showThread.events
  'click .load-more': (e)->
    e.preventDefault()
    Session.set('bodyScrollTop', $('body').scrollTop())
    Session.set('msgWrapHeight', $('#msg-wrap').height())
    mixpanel.track "Thread: 'show more' click"
    Router.go(@nextPath)

  'click #enter-chat': (e) ->
    Notify.toggleIsMuted(false, "Entered the chat", @threadId, @userIndex)
    mixpanel.track "Thread: 'Re-entered chat"

