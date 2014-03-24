exports = this
exports.Notes = new Meteor.Collection('notes')

Meteor.methods
  post: (noteAttributes) ->
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
      expiresAt: now + (7*24*60*60) # 7 days from now (in seconds)
    )

    Notes.insert(note)