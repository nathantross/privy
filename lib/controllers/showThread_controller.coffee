exports = this
exports.showThreadController = RouteController.extend(
  template: "showThread"

  onBeforeAction: ->
    threadId = @params._id
    user = Meteor.user()
    if user
      unless user.status?.idle
        Notify.toggleCheckIn(threadId, true) 

        # Turn off the notification, if there is one
        notification = Notifications.findOne
          threadId: threadId
          userId: user._id
          isNotified: true

        if notification
          Notify.toggleItemHighlight(notification, false) 
          Meteor.call 'readMessage', threadId, (error, id) ->
            console.log(error.reason) if error

          if user.notifications[0].isTitleFlashing
            document.title = Notify.defaultTitle()

  onStop: ->
    Notify.toggleCheckIn(@threadId(), false)
    $body = $("input")
    $body.val("")

  increment: 15

  limit: ->
    parseInt(@params.msgLimit) || @increment

  threadId: ->
    @params._id

  waitOn: ->
    Subs.subscribe "oneThread", @threadId()
    Subs.subscribe "messages", @threadId(), @limit()

  messages: ->
    Messages.find
      threadId: @threadId()
    ,
      sort: 
        createdAt: 1
      limit: @limit()

  data: ->
    hasMore = @messages().count() == @limit()
    nextPath = @route.path
      _id: @threadId()
      msgLimit: (@limit() + @increment)

    return(  
      messages: @messages()
      nextPath: (if hasMore then nextPath else null)
      threadId: @threadId()
      userIndex: Notify.userIndex(@threadId())
      # lastMessage: @lastMessage()
    )
)
