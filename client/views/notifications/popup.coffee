Template.popup.helpers
  notification: ->
    Notifications.findOne(
        {}
      , 
        sort:
          updatedAt: -1
    )

Template.popup.events
  'click #popup': (event)->
    notification = Notifications.findOne(
        {}
      , 
        sort:
          updatedAt: -1
    )
    Notify.toggleItemHighlight(notification, false)
    Notify.toggleNavHighlight(false) unless Notify.anyItemsNotified()
    Notify.toggleTitleFlashing(false)
    $('#popup').slideUp('slow')
