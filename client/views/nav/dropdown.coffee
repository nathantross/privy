Template.dropdown.helpers
  hasNotification: ->
    Notifications.findOne({isArchived: false})?

Template.dropdown.events
  'click #sign-out': ->
    mixpanel.track("User: signed out")

  'click .navlogo': ->
    mixpanel.track("Nav: clicked logo")

  'click #settings': ->
    mixpanel.track("Nav: clicked settings")

  'click #noteFeedChevron': ->
    mixpanel.track("Nav: clicked noteFeedChevron")

    