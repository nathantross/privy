exports = this
exports.showThreadController = RouteController.extend(
  template: "showThread"
  
  onRun: ->
    threadId = @params._id

    # Add user as a participant on the thread
    Meteor.call('checkIn', threadId, (error, id) ->
      alert(error.reason) if error
    )

    # Turn off the notification, if there is one
    notification = Notifications.findOne
      threadId: threadId
      userId: Meteor.userId()
      isNotified: true

    Notify.toggleItemHighlight(notification, false) if notification

    Meteor.call('readMessage', threadId, (error, id) ->
      alert(error.reason) if error 
    )

    Meteor.defer ->
        $('#threads-link').removeClass('open')

    # if Meteor.isServer
    #   thread = Threads.findOne(threadId)
    #   for participant, i in thread.participants
    #     if participant.userId == Meteor.userId()
    #       Session.set("participantIndex", i)


  onStop: ->
    Meteor.call('checkOut', @threadId(), (error, id) ->
      alert(error.reason) if error
    )
    $body = $("input")
    $body.val("")

  waitOn: ->
    Meteor.subscribe "messages", @threadId(), @sort()
    # Meteor.subscribe 'threads'
    # Meteor.subscribe "thread", Session.get("threadId")
    
  # FOR PAGINATION WHEN WE WANT TO ADD IT
  # increment: 1
  # limit: ->
  #   parseInt(@params.notesLimit) || @increment
  sort: ->
    updatedAt: 1

  threadId: ->
      @params._id

  messages: ->
    Messages.find
      threadId: @threadId()
    ,
      sort:
        @sort()

  # participantIndex: ->
  #   thread = Threads.findOne(@threadId())
  #   for participant, i in thread.participants
  #     if participant.userId == Meteor.userId()
  #       return i

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
      # participantIndex: @participantIndex()
      # lastMessage: @lastMessage()
      
    )
)

