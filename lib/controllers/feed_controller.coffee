exports = this
exports.FeedController = RouteController.extend(
  template: "feed"

  findOptions: ->
    sort:
      updatedAt: 1

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
    note: @note()
)