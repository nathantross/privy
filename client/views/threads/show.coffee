Template.showThread.helpers
  isMuted: ->
    Threads.findOne(@threadId)?.participants[@userIndex].isMuted

  isBlocked: ->
    thread = Threads.findOne(@threadId) if @threadId?
    if thread && @userIndex? && thread.participants.length == 2
      blockedIndex = if @userIndex == 1 then 0 else 1
      blockedId = thread.participants[blockedIndex].userId
      return _.indexOf(Meteor.user().blockedIds, blockedId) > -1
    else
      false

  hasTwoParticipants: ->
    if @threadId?
      thread = Threads.findOne(@threadId) 
      thread.participants.length == 2


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

