Meteor.startup(function() {
  Kadira.connect(Meteor.settings.appId, Meteor.settings.appSecret)
});