exports = this
exports.showThreadController = RouteController.extend(
  template: "showThread"
  
  onRun: ->
    threadId = @params._id

    # if Meteor.isServer
    #   thread = Threads.findOne(threadId)
    #   for participant, i in thread.participants
    #     if participant.userId == Meteor.userId()
    #       Session.set("participantIndex", i)

    Meteor.call('checkIn', threadId, (error, id) ->
      alert(error.reason) if error
    )
    Meteor.call('readMessage', threadId, (error, id) ->
      alert(error.reason) if error
    )

  onStop: ->
    Meteor.call('checkOut', @threadId(), (error, id) ->
      alert(error.reason) if error
    )
    $body = $("input") #.find('[name=message-body]')
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

