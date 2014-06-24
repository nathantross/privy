Template.threadNav.helpers
  isMuted: ->
    @participants[@userIndex].isMuted if @participants

  isBlocked: ->
    if @participants && @userIndex? && @participants.length == 2
      blockedIndex = if @userIndex == 1 then 0 else 1
      blockedId = @participants[blockedIndex].userId
      return _.indexOf(Meteor.user().blockedIds, blockedId) > -1
    else
      false

  hasTwoParticipants: ->
    @participants.length == 2 if @participants

  isNavNotified: ->
    user = Meteor.user()
    if user && user.notifications[0].isNavNotified then "nav-notify" else ""

Template.threadNav.events
  'click #dropdown-li': (event)->
    Notify.toggleNavHighlight(false)
    Notify.toggleTitleFlashing(false)
    mixpanel.track("Nav: clicked comment bubble")

  'click #leave-chat': (e) ->
    mixpanel.track "ThreadNav: left chat"
    Notify.toggleIsMuted(true, "Left the chat", @threadId, @userIndex)
    Router.go('feed')

  'click #block-user': (e)->
    e.preventDefault()
    $('#block-user-alert').removeClass "closed"

    blockedIndex = if @userIndex == 1 then 0 else 1
    blockedId = Threads.findOne(@threadId).participants[blockedIndex].userId

    mixpanel.track("ThreadNav: clicked block user", {
      threadId: @threadId 
      blockerId: Meteor.userId()
      blockedId: blockedId
    })

  'click #more-actions': ->
    mixpanel.track "ThreadNav: clicked 'more actions'"

  # 'click #unblock-user': (e)->
  #   e.preventDefault()
  #   Notify.toggleBlock(false, @threadId, @userIndex)