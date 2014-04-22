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

Template.successAlert.alertCopy = Session.get('alertCopy')