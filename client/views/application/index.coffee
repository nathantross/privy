Template.index.helpers
  getStarted: ->
    if Meteor.user() then "feed" else "register"

  signOut: ->
    Meteor.logout()
    "logout"

Template.index.events
  'mouseover .tooltip': (e) -> 
    $('.tooltip').tooltip('show')


Template.navbar.helpers
  getStarted: ->
    if Meteor.user() then "feed" else "register"

  signOut: ->
    Meteor.logout()
    "logout"