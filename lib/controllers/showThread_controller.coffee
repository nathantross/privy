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
    # Meteor.subscribe "thread", @threadId()

  messages: ->
    Messages.find
      threadId: @threadId()
    ,
      sort:
        @sort()

  data: ->
    return (
      messages: @messages()
      threadId: @threadId()
    )
)

