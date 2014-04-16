exports = this
exports.showThreadController = RouteController.extend(
  template: "showThread"
  
  onBeforeAction: ->
    user = Meteor.user()
    threadId = @params._id
    thread = Threads.findOne(threadId)
    
    if @ready() && user && thread
      toggleCheckIn(threadId, true)

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
    Meteor.subscribe "messages", @threadId(), @sort()

  onStop: ->
    toggleCheckIn(@threadId(), false)
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
      userIndex: userIndex(@threadId())
      # lastMessage: @lastMessage()
    )

  toggleCheckIn = (threadId, toggle) ->
    thread = Threads.findOne(threadId)
    index = userIndex(threadId)
    unless thread && thread.participants[index].isInThread == toggle 
      threadAttr =
        threadId: threadId
        toggle: toggle
        userIndex: index

      Meteor.call('toggleIsInThread', threadAttr, (error, id) ->
        alert(error.reason) if error
      )

  userIndex = (threadId) ->
    thread = Threads.findOne(threadId)
    if thread
      for participant, i in thread.participants
        if participant.userId == Meteor.userId()
          return i
    false
)

