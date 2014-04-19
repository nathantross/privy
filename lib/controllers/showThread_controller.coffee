exports = this
exports.showThreadController = RouteController.extend(
  template: "showThread"
  
  onBeforeAction: ->
    user = Meteor.user()
    threadId = @params._id
    thread = Threads.findOne(threadId)

    if @ready() && user && thread
      unless UserStatus.isIdle()
        Notify.toggleCheckIn(threadId, true) 

        # Turn off the notification, if there is one
        notification = Notifications.findOne
          threadId: threadId
          userId: Meteor.userId()
          isNotified: true

        Notify.toggleItemHighlight(notification, false) if notification

        $({})
          .queue((next)->
            Meteor.call('readMessage', threadId, (error, id) ->
              alert(error.reason) if error
            )
            next()
          ).queue((next)->
            document.title = Notify.defaultTitle(user)
          )

  threadId: ->
    @params._id

  waitOn: ->
    Meteor.subscribe "messages", @threadId(), @sort() if Notify.isParticipant(Meteor.userId(), @threadId())

  onStop: ->
    Notify.toggleCheckIn(@threadId(), false)
    $body = $("input")
    $body.val("")

  sort: ->
    createdAt: 1

  messages: ->
    Messages.find
      threadId: @threadId()
    ,
      sort:
        @sort()

  # lastMessage: ->
  #   if Meteor.isServer
  #     Messages.findOne
  #         threadId: @threadId()
  #       ,
  #         sort:
  #             updatedAt: -1

  data: ->
    return (
      messages: @messages()
      threadId: @threadId()
      userIndex: Notify.userIndex(@threadId())
      # lastMessage: @lastMessage()
    )
)

