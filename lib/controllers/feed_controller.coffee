exports = this
exports.FeedController = RouteController.extend(
  template: "feed"
  # increment: 1
  # notesCount: ->
    # parseInt(@params.notesCount) || @increment

  onBeforeAction: ->
    document.title = Notify.defaultTitle()

  findOptions: ->
    sort:
      createdAt: 1
    # limit: @increment

  waitOn: ->
    Meteor.subscribe "notes", @findOptions()
    Meteor.subscribe "noteActions"

  note: ->
    noteIds = 
      NoteActions.find(
        isSkipped: true 
        receiverId: Meteor.userId()
      ).map((na) -> na.noteId) || []
    
    Notes.findOne(
        _id: 
          $nin: noteIds
        isInstream: true
      , @findOptions())

  data: ->
    return(
      note: @note()
      # nextPath: @route.path(notesCount: @notesCount() + @increment)
    )
    # hasMore = @notes().fetch().length is @limit()
    
    # return (
    #   isPassing: true
    #   notes: @notes()
    #   nextPath: (if hasMore then nextPath else null)
    # )
)