Template.navbar.events
  'click #threads-link': ->
    if Meteor.user().profile.isNotified
      Meteor.users.update Meteor.userId(),
        $set:
          "profile.isNotified": false