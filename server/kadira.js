Meteor.startup(function() {
  Kadira.connect(Meteor.settings.kadira.appId, Meteor.settings.kadira.appSecret);
});