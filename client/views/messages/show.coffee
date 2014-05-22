Template.showMessage.helpers
  senderAvatar: ->
    Meteor.users.findOne(@senderId).profile.avatar if @senderId
  
  currentUserIsSender: ->
    @senderId == Meteor.userId() if @senderId

  hasExited: ->
    @hasExited == true

Template.showMessage.rendered = ->
  lastMessage =
    Messages.findOne
        threadId: @data.threadId
      ,
        sort:
            createdAt: -1
  
  if @data._id == lastMessage._id
    if Session.get('bodyScrollTop')
      $('body').scrollTop(
        $('#msg-wrap').height() - Session.get('msgWrapHeight') + Session.get('bodyScrollTop')
      )
      Session.set('bodyScrollTop', false)
      Session.set('msgWrapHeight', false)
    else
      $('body').scrollTop($("#messages")[0].scrollHeight)
    