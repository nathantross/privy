Template.message.helpers
  sender: ->
    Meteor.users.findOne(@senderId)

  currentUserIsSender: ->
    Meteor.users.findOne(@senderId)._id == Meteor.userId()
