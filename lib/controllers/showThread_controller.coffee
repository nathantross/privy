exports = this
exports.showThreadController = RouteController.extend(
  template: "showThread"
  
  onRun: ->
    threadId = @params._id
    console.log "Thread is reloaded - id: " + threadId
    user = Meteor.user()
    thread = Threads.findOne(threadId)

    if user && thread && threadId
      toggleCheckIn(threadId, true)

      # Turn off the notification, if there is one
      notification = Notifications.findOne
        threadId: threadId
        userId: Meteor.userId()
        isNotified: true

      Notify.toggleItemHighlight(notification, false) if notification

      Meteor.call('readMessage', threadId, (error, id) ->
        if error 
          alert(error.reason) 
        # else
        #   document.title = Notify.defaultTitle(Meteor.user())
      )

  threadId: ->
    @params._id

  waitOn: ->
    Meteor.subscribe "messages", @threadId(), @sort()
    console.log "Subscribed to messages"

  onStop: ->
    console.log "checking out"
    toggleCheckIn(@threadId(), false)
    $body = $("input")
    $body.val("")
    console.log "checked out"

  onData: ->
    console.log "Data loaded/changed"

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

