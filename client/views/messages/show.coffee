Template.showMessage.helpers
  senderAvatar: ->
    participants = Threads.findOne(@threadId).participants
    for p in participants
      return p['avatar'] if p['userId'] == @senderId
  
  currentUserIsSender: ->
    @senderId == Meteor.userId()

Template.showMessage.rendered = ->
    lastMessage =
      Messages.findOne
          threadId: @data.threadId
        ,
          sort:
              createdAt: -1
    
    if @data._id == lastMessage._id
      $('body').scrollTop($("#messages")[0].scrollHeight)