exports = this
exports.showThreadController = RouteController.extend(
  template: "showThread"
  
  # FOR PAGINATION WHEN WE WANT TO ADD IT
  # increment: 1
  # limit: ->
  #   parseInt(@params.notesLimit) || @increment
  sort: ->
    updatedAt: 1

  threadId: ->
      @params._id

  waitOn: ->
    Meteor.subscribe "messages", @threadId(), @sort()
    # Meteor.subscribe 'threads'
    # Meteor.subscribe "thread", @threadId()

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
  #   Messages.findOne
  #       threadId: @threadId()
  #     ,
  #       sort:
  #           updatedAt: -1

  data: ->
    return (
      messages: @messages()
      threadId: @threadId()
      # participantIndex: @participantIndex()
      #lastMessage: @lastMessage()
      
    )
)

