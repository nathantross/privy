Template.signedInNav.events
  'click #threads-link': (event)->
    Notify.toggleNavHighlight(false)
    Notify.toggleTitleFlashing(false)
    isDropdownOpen = Session.get('isDropdownOpen')
    Session.set('isDropdownOpen', !isDropdownOpen)

  'click #sign-out': ->
    mixpanel.track("User: signed out")

  'click #noteFeed': ->
    mixpanel.track("Nav: clicked note feed")

  'click #settings': ->
    mixpanel.track("Nav: clicked settings")

  'click #logo': ->
    mixpanel.track("Nav: clicked logo")

  'click #addNote': ->
    mixpanel.track("Nav: clicked add note")

Template.signedInNav.helpers
  isNavNotified: ->
    user = Meteor.user().notifications
    if user && user[0].isNavNotified then "nav-notify" else ""

  isDropdownOpen: ->
    if Session.get('isDropdownOpen') then "open" else ""
