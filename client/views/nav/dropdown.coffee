Template.dropdown.helpers
  isNavNotified: ->
    user = Meteor.user().notifications
    if user && user[0].isNavNotified then "nav-notify" else ""

  'click #dropdown-li': (event)->
    Notify.toggleNavHighlight(false)
    Notify.toggleTitleFlashing(false)

Template.dropdown.events
  'click #sign-out': ->
    mixpanel.track("User: signed out")

  'click #noteFeed': ->
    mixpanel.track("Nav: clicked note feed")

  'click #settings': ->
    mixpanel.track("Nav: clicked settings")

  'click #logo': ->
    mixpanel.track("Nav: clicked logo")