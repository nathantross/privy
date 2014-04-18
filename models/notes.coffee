exports = this
exports.Notes = new Meteor.Collection('notes')

Meteor.methods
  createNote: (noteAttributes) ->
    user = Meteor.user()
    duplicateNote = Notes.findOne(
      body: noteAttributes.body
      userId: user._id
      isInstream: true
    )
    if !user
      throw new Meteor.Error(401, "You have to login to create a note.")

    if !noteAttributes.body
      throw new Meteor.Error(422, 'Woops, looks like your note is blank!')

    if noteAttributes.body && duplicateNote 
      throw new Meteor.Error(302,
          'This note\'s already in your stream.',
          duplicateNote._id
      )
      
    # whitelisted keys
    now = new Date().getTime()
    note = _.extend(_.pick(noteAttributes, 'body'),
      userId: user._id
      isInstream: true
      createdAt: now
      updatedAt: now
      expiresAt: (now + 7*24*60*60*1000) # 7 days from now (in ms)
    )

    Notes.insert(note)

  removeNoteFromStream: (noteId) ->
    isInstream = Notes.findOne(noteId).isInstream

    if !Meteor.userId()
      throw new Meteor.Error(401, "You have to login to remove a note.")

    if Notes.findOne(noteId).userId != Meteor.userId()
      throw new Meteor.Error(401, "You do not have access to this note.")      


    if !isInstream
      throw new Meteor.Error(409, "Bummer! Someone else replied while you were writing. Keep browsing.")

    now = new Date().getTime()
    Notes.update(noteId, 
      $set:
        isInstream: false
        updatedAt: now
    )

    noteId
