exports = this
exports.Threads = new Meteor.Collection('threads')

Meteor.methods
  send: (messageAttributes) ->
    user = Meteor.user()
    
    if !user
      throw new Meteor.Error(401, "You have to login to send a message.")

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