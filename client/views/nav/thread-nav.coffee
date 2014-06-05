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
      console.log thread.participants.length
      ans = thread.participants.length == 2
      console.log ans
      ans

  isNavNotified: ->
    user = Meteor.user()
    if user && user.notifications[0].isNavNotified then "nav-notify" else ""


Template.threadNav.events
  'click #dropdown-li': (event)->
    Notify.toggleNavHighlight(false)
    Notify.toggleTitleFlashing(false)

  'click #leave-chat': (e) ->
    Notify.toggleIsMuted(true, "Left the chat", @threadId, @userIndex)
    Router.go('feed')

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

  # 'click #unblock-user': (e)->
  #   e.preventDefault()
  #   Notify.toggleBlock(false, @threadId, @userIndex)