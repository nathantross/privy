exports = this
exports.showThreadController = RouteController.extend(
  template: "showThread"

  onBeforeAction: ->
    console.log "testing123"
    # threadId = @params._id

    # if Meteor.user() && Threads.findOne(threadId)
    #   unless Meteor.user().status.idle
    #     Notify.toggleCheckIn(threadId, true) 

    #     # Turn off the notification, if there is one
    #     notification = Notifications.findOne
    #       threadId: threadId
    #       userId: Meteor.userId()
    #       isNotified: true

    #     if notification
    #       Notify.toggleItemHighlight(notification, false) 
    #       Meteor.call 'readMessage', threadId, (error, id) ->
    #         console.log(error.reason) if error

    #       if Meteor.user().notifications[0].isTitleFlashing
    #         document.title = Notify.defaultTitle()

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
    Meteor.subscribe "oneThread", @threadId()
    Meteor.subscribe "messages", @threadId(), @limit()

  messages: ->
    Messages.find
      threadId: @threadId()
    ,
      sort: 
        createdAt: 1
      limit: @limit()

  thread: ->
    Threads.findOne @threadId() if @threadId()

  data: ->
    hasMore = @messages().count() == @limit()
    nextPath = @route.path
      _id: @threadId()
      msgLimit: (@limit() + @increment)

    return(  
      messages: @messages()
      nextPath: (if hasMore then nextPath else null)
      threadId: @threadId()
      thread: @thread()
      userIndex: Notify.userIndex(@threadId())
      # lastMessage: @lastMessage()
    )
)
