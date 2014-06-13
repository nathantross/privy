Template.threadNav.helpers
  isMuted: ->
    @thread.participants[@userIndex].isMuted if @thread

  isBlocked: ->
    if @thread && @userIndex? && @thread.participants.length == 2
      blockedIndex = if @userIndex == 1 then 0 else 1
      blockedId = @thread.participants[blockedIndex].userId
      return _.indexOf(Meteor.user().blockedIds, blockedId) > -1
    else
      false

  hasTwoParticipants: ->
    @thread.participants.length == 2 if @thread

  isNavNotified: ->
    user = Meteor.user()
    if user && user.notifications[0].isNavNotified then "nav-notify" else ""

  partner: ->
    if @thread
      partnerIndex = if @userIndex == 0 then 1 else 0
      partnerId = @thread.participants[partnerIndex]?.userId
      Notify.getUserStatus(partnerId) if partnerId

  # hasPoint: ->
  #   if @thread
  #     partnerIndex = if @userIndex == 0 then 1 else 0
  #     @thread.participants[partnerIndex]?.hasPoint


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

  # 'click #hasPoint': (e)->
  #   e.preventDefault()
  #   partnerIndex = if @userIndex == 0 then 1 else 0

  #   Meteor.call "toggleHasPoint", @threadId, partnerIndex, (err) ->
  #     console.log err if err 

  'click #give-point': (e)->
    e.preventDefault()
    partnerIndex = if @userIndex == 0 then 1 else 0
    userIndex = @userIndex

    unless @thread.participants[partnerIndex]?.hasPoint || !@threadId
      Meteor.call 'givePoint', @threadId, partnerIndex, @userIndex, (err, threadId) ->
        return console.log err if err
        
        messageAttr = 
          body: "++PlusPoint"
          threadId: threadId
          isPoint: true
      
        Meteor.call "createMessage", messageAttr, (err) ->
          return console.log err if err

        thread = Threads.findOne threadId
        mixpanel.track("ThreadNav: gave point", {
          threadId: threadId
          giver: thread.participants[partnerIndex].userId
          receiver: thread.participants[userIndex].userId
        })


  'click #more-actions': ->
    mixpanel.track "ThreadNav: clicked 'more actions'"

  # 'click #unblock-user': (e)->
  #   e.preventDefault()
  #   Notify.toggleBlock(false, @threadId, @userIndex)