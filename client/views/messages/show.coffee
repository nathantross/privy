Template.showMessage.helpers
  sender: ->
    Meteor.users.findOne(_id: @senderId)

  senderAvatar: ->
    participants = Threads.findOne(@threadId).participants
    for p in participants
      return p['avatar'] if p['userId'] == @senderId
  
  currentUserIsSender: ->
    @senderId == Meteor.userId()
