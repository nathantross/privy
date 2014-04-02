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
    Meteor.subscribe "thread", @threadId()
    Meteor.subscribe "threadUsers", @threadId()
    Meteor.subscribe "messages", @threadId()

  # notes: ->
  #   noteIds = 
  #     NoteActions.find(
  #       isSkipped: true 
  #       receiverId: Meteor.userId()
  #     ).map((na) -> na.noteId)
  #   noteIds = [] unless noteIds
    
  #   Notes.find(
  #       _id: 
  #         $nin: noteIds
  #       isInstream: true
  #     , @findOptions())

)

