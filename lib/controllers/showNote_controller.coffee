exports = this
exports.showNoteController = RouteController.extend(
  template: "feed"

  noteId: ->
    @params._id

  waitOn: ->
    Subs.subscribe "oneNote", @params._id

  note: ->
    note = Notes.findOne @noteId()
    console.log note
    note
    
  userAttr: ->
    Notify.getUserStatus(@note().userId)

  data: ->
    return(
      note: @note()
      userAttr: @userAttr()
    )
)