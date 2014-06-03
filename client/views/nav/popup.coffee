Template.newMessageAlert.helpers
  notification: ->
    notification = Notifications.findOne {}, 
        sort:
          updatedAt: -1

    if notification
      userId = notification.lastAvatarId 

      if userId
        avatar = Notify.getUserStatus(userId, true, false)

        _.extend notification,
          avatar: avatar


Template.newMessageAlert.events
  'click #newMessageAlert': (event)->
    notification = Notifications.findOne {}, 
        sort:
          updatedAt: -1

    Notify.toggleItemHighlight(notification, false)
    Notify.toggleNavHighlight(false) unless Notify.anyItemsNotified()
    Notify.toggleTitleFlashing(false)
    $('#newMessageAlert').slideUp('slow')

Template.flagAlert.events
  'click .flag-btn': (e)->
    e.preventDefault()
    $('#flagAlert').slideUp('slow')

  'click #flag-confirm': (e)->
    Meteor.call 'flag', @note._id, (err, res) ->
      console.log err if err
    
    mixpanel.track("Flag: created", {
      noteId: @note._id, 
      body: @note.body, 
      creatorId: @note.userId, 
      creatorIsOnline: if !@userAttr.isIdle then "Yes" else "No"
    })

Template.blockUserAlert.events
  'click .block-btn': (e)->
    e.preventDefault()
    $('#block-user-alert').slideUp('slow')

  'click #block-confirm': (e)->
    Notify.toggleBlock(true, @threadId, @userIndex)
    Router.go('feed')

Template.firstSkipAlert.events
  'click .skip-btn': (e) ->
    e.preventDefault()
    $('#first-skip-alert').slideUp "slow"
    Session.set 'isSkipAlert', false

  'click #skip-confirm': (e)->
    Meteor.call 'skipNote', @note._id, @userAttr.isIdle, (error, id) -> 
      console.log(error.reason) if error
    