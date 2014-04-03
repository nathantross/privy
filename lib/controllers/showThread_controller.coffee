exports = this
exports.showThreadController = RouteController.extend(
  template: "showThread"
  
  # FOR PAGINATION WHEN WE WANT TO ADD IT
  # increment: 1
  # limit: ->
  #   parseInt(@params.notesLimit) || @increment

  threadId: ->
      @params._id

  findOptions: ->
    sort:
      updatedAt: 1
    # limit: @limit()

  waitOn: ->
    Meteor.subscribe "messages", @threadId()

  # data: ->
  #   return (
  #     sender: @sender
      
  #     notes: @notes()
  #     nextPath: (if hasMore then nextPath else null)
  #   )
)

