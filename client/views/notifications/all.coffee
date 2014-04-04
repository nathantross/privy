Template.allNotifications.helpers
  notifications: ->
    Notifications.find userId: Meteor.userId(),
      sort:
        updatedAt: -1