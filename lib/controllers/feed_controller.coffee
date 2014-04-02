exports = this
exports.FeedController = RouteController.extend(
  template: "feed"
  increment: 5
  limit: ->
    parseInt(@params.notesLimit) || @increment

  findOptions: ->
    sort:
      updatedAt: 1
    limit: @limit()

  waitOn: ->
    Meteor.subscribe "notes", @findOptions()
    Meteor.subscribe "noteActions"

  note: ->
    noteIds = 
      NoteActions.find(
        isSkipped: true 
        receiverId: Meteor.userId()
      ).map((na) -> na.noteId)
    noteIds = [] unless noteIds
    
    Notes.findOne(
        _id: 
          $nin: noteIds
        isInstream: true
      , @findOptions())

  data: ->
    note: @note()
    # hasMore = @notes().fetch().length is @limit()
    # nextPath = @route.path(notesLimit: @limit() + @increment)
    # return (
    #   isPassing: true
    #   notes: @notes()
    #   nextPath: (if hasMore then nextPath else "#")
    # )
)
