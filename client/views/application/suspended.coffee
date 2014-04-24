Template.suspended.helpers
  userEmail: ->
    Meteor.user().emails[0].address if Meteor.user()