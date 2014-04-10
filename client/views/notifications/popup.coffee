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
    $('#popup').slideUp('slow')