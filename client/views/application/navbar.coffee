Template.navbar.events
  'click #threads-link': (event)->
    Notify.toggleNavHighlight(Meteor.user(), false)
    isDropdownOpen = Session.get('isDropdownOpen')
    Session.set('isDropdownOpen', !isDropdownOpen)

Template.navbar.helpers
  isNavNotified: ->
    user = Meteor.user()
    if user.notifications[0].isNavNotified then "nav-notify" else ""

  isDropdownOpen: ->
    if Session.get('isDropdownOpen') then "open" else ""