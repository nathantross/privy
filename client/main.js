if (Meteor.isClient) {
  Meteor.startup(function () {
    mixpanel.init('8fae59e0f1928d0b271b70446613466f');

    mixpanel.track("Application Startup", {
    });

  });
}