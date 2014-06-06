exports = this
exports.Notes = new Meteor.Collection('notes')

Meteor.methods

  createNote: (noteAttr, isChecked) ->

    # Declare variables / functions
    getLocation = (ipAddr) ->
      if Meteor.settings.ipInfo
        locationJSON = 
          HTTP.get "https://api.ipinfodb.com/v3/ip-city/?",
            timeout: 5000
            params:
              format: "json"
              key: Meteor.settings.ipInfo
              ip: ipAddr
        
        if locationJSON.statusCode == 200
          loc = locationJSON.data
          locId = Locations.insert loc
          return loc

        else
          console.log "IpInfo call failed with error: " + locationJSON.statusMessage
        
      false

    user = Meteor.user()
    # maxReplies = noteAttr.maxReplies


    # Check for errors 
    unless user
      throw new Meteor.Error 401, "You have to login to create a note."

    unless noteAttr.body && noteAttr.body.length > 0
      throw new Meteor.Error 422, 'Whoops, looks like your note is blank!'

    unless noteAttr.body.length < 121
      throw new Meteor.Error 422, 'Your note is a liiiittle too long.'

    unless noteAttr.threadId
      throw new Meteor.Error 422, 'You need a threadId for your note.'

    # unless maxReplies == 1 || maxReplies == 3 || maxReplies == 5
    #   throw new Meteor.Error 422, "You can only get 1, 3, or 5 replies."

    if Meteor.isServer
      duplicateNote = Notes.findOne(
        body: noteAttr.body
        userId: user._id
        isInstream: true
      )

      if noteAttr.body && duplicateNote 
        throw new Meteor.Error 302, 'This note\'s already in your stream.', duplicateNote._id 

      unless Threads.findOne(noteAttr.threadId)
        throw new Meteor.Error 422, 'You need a thread for your note.'


    # Set note attributes
    now = new Date().getTime()
    noteAttr = _.extend(_.pick(noteAttr, 'body', 'threadId'), #, 'maxReplies'),
      userId: user._id
      isInstream: true
      createdAt: now
      updatedAt: now
      expiresAt: (now + 7*24*60*60*1000) # 7 days from now (in ms)
    )
    
    # Add location to note
    if isChecked && Meteor.isServer
      ipAddr = @connection.clientAddress
      console.log "ipAddr"
      console.log ipAddr
      
      location = Locations.findOne ipAddress: ipAddr  
      console.log "location 1"
      console.log location

      location = getLocation(ipAddr) unless location  
      console.log "location 2"
      console.log location

      if location 
        noteAttr = _.extend noteAttr,
          loc:
            lng: location.longitude
            lat: location.latitude
          place:
            city: location.cityName
            region: location.regionName
            country: location.countryName
      
      console.log "noteAttr"
      console.log noteAttr
      
    # Create the note
    noteId = Notes.insert(noteAttr)


    # Track note creation in mixpanel
    if Meteor.isClient
      mixpanel.track('Note/Thread: created') 
      # mixpanel.track('Note: #{maxReplies} replies') 
      includeLocation = if isChecked then "on" else "off"
      mixpanel.track('Note: location #{includeLocation}')

    # Return attributes to callback
    response = 
      threadId: noteAttr.threadId
      noteId: noteId

  addNoteReplier: (noteAttr) ->
    # Add a replier to the note
    user = Meteor.user()
    note = Notes.findOne(noteAttr.noteId)

    unless user._id
      throw new Meteor.Error(401, "You have to login to remove a note.") 

    unless note
      throw new Meteor.Error(404, "Your note is missing.")

    if note.replierIds? && _.indexOf(note.replierIds, user._id) != -1
      throw new Meteor.Error 302, 'You already replied to this note.'

    unless note.isInstream
      throw new Meteor.Error(409, "Bummer! This note's been removed.")

    # isInstream = !(note.replierIds && note.replierIds.length >= note.maxReplies - 1)

    now = new Date().getTime()
    Notes.update noteAttr.noteId, 
      $set:
        # isInstream: isInstream
        updatedAt: now
      $addToSet:
        replierIds: user._id

    # Add a participant to the thread
    if Meteor.isServer
      thread = Threads.findOne(noteAttr.threadId)
      user = Meteor.user()
      sender = Meteor.users.findOne(noteAttr.senderId)
      
      unless user
        throw new Meteor.Error 401, "You have to login to respond to a thread."

      unless thread
        throw new Meteor.Error 401, "This thread doesn't exist."
      
      unless sender
        throw new Meteor.Error 404, "The note creator doesn't exist as a user."

      unless noteAttr.body
          throw new Meteor.Error 422, 'Looks like your message is blank!'

      # if the thread has more than two participants, we'll create a new thread
      if thread.participants.length >= 2

        # We create the thread here
        thread = 
          participants: [
              userId: user._id
            , 
              userId: sender._id
          ] 
          createdAt: now
          updatedAt: now

        threadId = Threads.insert(thread)
        
        # Here we create backfill the note here
        message = _.extend(_.pick(noteAttr, 'senderId', 'body', 'createdAt'),
          threadId: threadId
          updatedAt: now
          isRead: false 
        )    
        Messages.insert(message)
        return threadId

      else
        Threads.update thread._id, 
          $set:
            updatedAt: now
          $addToSet:
            participants: 
              userId: user._id
        
        return thread._id

  skipNote: (noteId, userIsOnline) ->
    note = Notes.findOne(noteId)

    unless Meteor.userId()
      throw new Meteor.Error(401, "You have to login to remove a note.") 

    unless noteId
      throw new Meteor.Error(404, "Your noteId is missing.")

    unless note
      throw new Meteor.Error(404, "This note doesn't exist.")    

    now = new Date().getTime()
    Notes.update noteId, 
      $set:
        updatedAt: now
      $addToSet:
        skipperIds: Meteor.userId()

    if Meteor.isClient
      mixpanel.track('Note: skipped', {
        noteId: note._id, 
        body: note.body, 
        creatorId: note.userId, 
        creatorIsOnline: if userIsOnline then "Yes" else "No"
      }) 
      
      Notify.toggleLock Session.get('currentNoteId'), false
      

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
