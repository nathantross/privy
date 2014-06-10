exports = this
exports.showThreadController = RouteController.extend(
  template: "showThread"

  onBeforeAction: ->
    user = Meteor.user()
    threadId = @params._id
    thread = Threads.findOne(threadId)

    if user && thread
      unless Meteor.user().status.idle
        Notify.toggleCheckIn(threadId, true) 

        # Turn off the notification, if there is one
        notification = Notifications.findOne
          threadId: threadId
          userId: Meteor.userId()
          isNotified: true

        Notify.toggleItemHighlight(notification, false) if notification

        $({})
          .queue((next)->
            Meteor.call 'readMessage', threadId, (error, id) ->
              console.log(error.reason) if error
            next()
          ).queue((next)->
            document.title = Notify.defaultTitle(user)
          )

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
