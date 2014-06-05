Template.threadNav.helpers
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

  isNavNotified: ->
    user = Meteor.user().notifications
    if user && user[0].isNavNotified then "nav-notify" else ""


Template.threadNav.events
  'click .load-more': (e)->
    e.preventDefault()
    Session.set('bodyScrollTop', $('body').scrollTop())
    Session.set('msgWrapHeight', $('#msg-wrap').height())
    Router.go(@nextPath)

  'click #leave-chat': (e) ->
    Notify.toggleIsMuted(true, "Left the chat", @threadId, @userIndex)
    Router.go('feed')

  'click #enter-chat': (e) ->
    Notify.toggleIsMuted(false, "Entered the chat", @threadId, @userIndex)

  'click #block-user': (e)->
    e.preventDefault()
    $('#block-user-alert').removeClass "closed"

    blockedIndex = if @userIndex == 1 then 0 else 1
    blockedId = Threads.findOne(@threadId).participants[blockedIndex].userId

    mixpanel.track("Block user: clicked", {
      threadId: @threadId 
      blockerId: Meteor.userId()
      blockedId: blockedId
    })

  'click #unblock-user': (e)->
    e.preventDefault()
    Notify.toggleBlock(false, @threadId, @userIndex)