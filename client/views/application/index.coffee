Template.index.helpers
  getStarted: ->
    if Meteor.user() then "feed" else "register"

  signOut: ->
    Meteor.logout()
    "logout"