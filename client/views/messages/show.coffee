Template.showMessage.helpers
  sender: ->
    Meteor.users.findOne(_id: @senderId)

  currentUserIsSender: ->
    @senderId == Meteor.userId()
