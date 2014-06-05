Template.dropdown.helpers
  hasNotification: ->
    Notifications.findOne({isArchived: false})?

Template.dropdown.events
  'click #sign-out': ->
    mixpanel.track("User: signed out")

  'click #noteFeed': ->
    mixpanel.track("Nav: clicked note feed")

  'click #settings': ->
    mixpanel.track("Nav: clicked settings")

  'click #logo': ->
    mixpanel.track("Nav: clicked logo")

  'click #dropdown-li': (event)->
    Notify.toggleNavHighlight(false)
    Notify.toggleTitleFlashing(false)