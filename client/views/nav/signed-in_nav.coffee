Template.signedInNav.events
  'click #threads-link': (event)->
    Notify.toggleNavHighlight(false)
    Notify.toggleTitleFlashing(false)
    isDropdownOpen = Session.get('isDropdownOpen')
    Session.set('isDropdownOpen', !isDropdownOpen)

Template.signedInNav.helpers
  isNavNotified: ->
    user = Meteor.user().notifications
    if user && user[0].isNavNotified then "nav-notify" else ""

  isDropdownOpen: ->
    if Session.get('isDropdownOpen') then "open" else ""