Template.navbar.events
  'click #threads-link': (event)->
    if Meteor.user().profile.isNotified
      Meteor.users.update Meteor.userId(),
        $set:
          "profile.isNotified": false
      Meteor.defer ->
        $('#threads-link').addClass('open')

Template.navbar.helpers
  isNavNotified: ->
    user = Meteor.user()
    user.notifications[0].isNavNotified