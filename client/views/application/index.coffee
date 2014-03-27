Template.index.helpers
  getStarted: ->
    if Meteor.user() then "feed" else "register"

  signOut: ->
    Meteor.logout()
    "logout"


Template.navbar.helpers
  getStarted: ->
    if Meteor.user() then "feed" else "register"

  signOut: ->
    Meteor.logout()
    "logout"