exports = this
exports.Notes = new Meteor.Collection('notes')

Meteor.methods
  createNote: (noteAttr) ->
    user = Meteor.user()

    unless user
      throw new Meteor.Error 401, "You have to login to create a note."

    unless noteAttr.body || noteAttr.body.length <= 0
      throw new Meteor.Error 422, 'Whoops, looks like your note is blank!'

    unless noteAttr.body.length < 66
      throw new Meteor.Error 422, 'Your note is a liiiittle too long.'

    unless noteAttr.threadId
      throw new Meteor.Error 422, 'You need a threadId for your note.'

    if Meteor.isServer
      duplicateNote = Notes.findOne(
        body: noteAttr.body
        userId: user._id
        isInstream: true
      )

      if noteAttr.body && duplicateNote 
        throw new Meteor.Error 302, 'This note\'s already in your stream.', duplicateNote._id 

      thread = Threads.findOne(noteAttr.threadId) if Meteor.isServer
      unless thread
        throw new Meteor.Error 422, 'You need a thread for your note.'
      
    # whitelisted keys
    now = new Date().getTime()
    note = _.extend(_.pick(noteAttr, 'body', 'threadId'),
      userId: user._id
      isInstream: true
      createdAt: now
      updatedAt: now
      expiresAt: (now + 7*24*60*60*1000) # 7 days from now (in ms)
    )

    Notes.insert(note)
    mixpanel.track('Note/Thread: created') if Meteor.isClient
    return noteAttr.threadId

  removeNoteFromStream: (noteAttr) ->
    isInstream = Notes.findOne(noteAttr.noteId).isInstream

    unless Meteor.userId()
      throw new Meteor.Error(401, "You have to login to remove a note.") 

    unless isInstream
      throw new Meteor.Error(409, "Bummer! Someone else replied while you were writing. Keep browsing.")

    now = new Date().getTime()
    Notes.update noteAttr.noteId, 
      $set:
        isInstream: false
        updatedAt: now

  skipNote: (noteId) ->
    unless Meteor.userId()
      throw new Meteor.Error(401, "You have to login to remove a note.") 

    unless noteId
      throw new Meteor.Error(404, "Your noteId is missing.")

    unless Notes.findOne(noteId)
      throw new Meteor.Error(404, "This note doesn't exist.")    

    now = new Date().getTime()
    Notes.update noteId, 
      $set:
        updatedAt: now
      $addToSet:
        skipperIds: Meteor.userId()
      

  toggleLock: (noteAttr) ->
    noteId = noteAttr.noteId
    isLocked = noteAttr.isLocked

    unless Meteor.userId()
      throw new Meteor.Error(401, "You have to login to lock a note.") 

    unless noteId
      throw new Meteor.Error(404, "Your noteId is missing.")

    unless Notes.findOne(noteId)
      throw new Meteor.Error(404, "This note doesn't exist.")        

    now = new Date().getTime()
    if isLocked 
      Notes.update noteId, 
        $set:
          currentViewer: Meteor.userId()
          updatedAt: now
    else
      Notes.update noteId, 
        $unset:
          currentViewer: ""
        $set:
          updatedAt: now   

  unlockAll: ->
    unless Meteor.userId()
      throw new Meteor.Error(401, "You have to login to lock a note.") 

    now = new Date().getTime()
    Notes.update 
        currentViewer: Meteor.userId()
      ,
        $unset:
          currentViewer: ""
        $set:
          updatedAt: now
      ,
        multi: true

  flag: (noteId)->
    note = Notes.findOne(noteId)
    
    unless Meteor.userId()
      throw new Meteor.Error(401, "You have to flag a note.") 

    unless noteId
      throw new Meteor.Error(404, "Your noteId is missing.")

    unless note
      throw new Meteor.Error(404, "This note doesn't exist.")

    Notes.update noteId,
      $addToSet:
        flaggerIds: Meteor.userId()
      $inc:
        flagCount: 1
    
    # Increment the note creator's flag count
    if Meteor.isServer && note.flagCount == 2
      user = Meteor.users.findOne(note.userId)
      userAttr = 
          $inc:
            'flags.count': 1
      
      if user.flags?.count >= 2
        userAttr['$set'] = 
          'flags.isSuspended': true 
      
        Notes.update 
            userId: note.userId
          ,
            $set:
              isInstream: false
          ,
            multi: true
      
      Meteor.users.update note.userId, userAttr
