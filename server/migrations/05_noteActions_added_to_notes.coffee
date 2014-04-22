Migrations.add
  name: 'Note actions are added to notes.'
  version: 5

  up: ->
    NoteActions.find().forEach (noteAction) ->
      Notes.update noteAction.noteId,
        $addToSet:
          skipperIds: noteAction.receiverId

      NoteActions.remove()

  down: ->
    exports = this
    exports.NoteActions = new Meteor.Collection('noteActions')

    Meteor.methods
      createNoteAction: (noteActionAttributes) ->
        user = Meteor.user()
        duplicateNoteAction = NoteActions.findOne(
          noteId: noteActionAttributes.noteId
          receiverId: user._id
        )

        if !user
          throw new Meteor.Error(401, "You have to login to pass this note.")

        if duplicateNoteAction 
          throw new Meteor.Error(302,
              'You\'ve already taken this action',
              duplicateNoteAction._id
          )
          
        # whitelisted keys
        now = new Date().getTime()
        noteAction = _.extend(_.pick(noteActionAttributes, 'noteId'),
          receiverId: user._id
          createdAt: now
          updatedAt: now
          isSkipped: true
        )

        NoteActions.insert(noteAction)

    now = new Date().getTime()
    Notes.find().forEach (note) ->
      for skipperId in note.skipperIds
        NoteAction.insert
          noteId: note._id
          receiverId: skipperId
          isSkipped: true
          createdAt: now
          updatedAt: now

      Notes.update note._id,
        $unset:
          skipperIds: ""
