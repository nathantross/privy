Template.navbar.helpers
  
  notify: ->
    Notifications.findOne 
      userId: Meteor.userId()
      isSeen: false

Template.navbar.events
  'click #threads-link': ->
    Notifications.update 
        userId: Meteor.userId()
        isSeen: false
      , 
        $set: 
          isSeen: true
    