Template.allNotifications.helpers
  notifications: ->
    Notifications.find 
        userId: Meteor.userId()
        isArchived: false
      , sort:
          updatedAt: -1