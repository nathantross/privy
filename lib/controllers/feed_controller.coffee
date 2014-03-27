exports = this
exports.FeedController = RouteController.extend(
  template: "feed"
  increment: 1
  limit: ->
    parseInt(@params.notesLimit) || @increment

  findOptions: ->
    sort:
      updatedAt: 1
    limit: @limit()

  waitOn: ->
    Meteor.subscribe "notes", @findOptions()

  notes: ->
    Notes.find isInstream: true, @findOptions()

  data: ->
    hasMore = @notes().fetch().length is @limit()
    nextPath = @route.path(notesLimit: @limit() + @increment)
    return (
      notes: @notes()
      nextPath: (if hasMore then nextPath else null)
    )
)