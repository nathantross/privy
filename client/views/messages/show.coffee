Template.showMessage.helpers
  senderAvatar: ->
    participants = Threads.findOne(@threadId).participants
    for p in participants
      return p['avatar'] if p['userId'] == @senderId
  
  currentUserIsSender: ->
    @senderId == Meteor.userId()
