Template.newMessageAlert.helpers
  notification: ->
    Notifications.findOne(
        {}
      , 
        sort:
          updatedAt: -1
    )

Template.newMessageAlert.events
  'click #newMessageAlert': (event)->
    notification = Notifications.findOne(
        {}
      , 
        sort:
          updatedAt: -1
    )
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
