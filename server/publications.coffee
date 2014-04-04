Meteor.publish "notifications", ->
  Notifications.find userId: @userId

Meteor.publish "noteActions", ->
  noteIds = 
    Notes.find( 
      isInstream: true
    ).map((n) -> n._id)

  NoteActions.find 
    noteId:
      $in: noteIds
    receiverId: @userId
    isSkipped: true

Meteor.publish "notes", (options) ->
  noteIds = 
      NoteActions.find(
        isSkipped: true 
        receiverId: @userId
      ).map((na) -> na.noteId) || []
    
    Notes.find
        _id: 
          $nin: noteIds
        isInstream: true
      , options

Meteor.publish "threads", ->
  Threads.find
      $or:[ creatorId: @userId,
            responderId: @userId
          ]
    , 
      fields:
        createdAt: 0

Meteor.publish "contacts", ->
  # userIds = Threads.find(
  #     participants: 
  #       $in: @userId
  #   ,
  #     fields:
  #       participants: 1
  #   ).distinct("participants")
  userIds = Threads.find()
  userIds.distinct("participants")

  Meteor.users.find
      _id:
        $in: userIds
    ,
      fields:
        _id: 1
        'profile.avatar': 1

  # userIds = Threads.find(
  #     $or:[ creatorId: @userId,
  #           responderId: @userId
  #         ]
  #   , 
  #     fields:
  #       creatorId: 1
  #       responderId: 1
  #   ).map( (thread) -> 
  #     if thread.creatorId == @userId
  #       thread.responderId
  #     else
  #       thread.creatorId  
  #   )


Meteor.publish "thread", (threadId) ->
  Threads.find
      _id: threadId
    ,
      fields:
        createdAt: 0
        updatedAt: 0
        noteId: 0
      limit: 1

Meteor.publish "messages", (threadId, sort) ->
  Messages.find
      threadId: threadId
    ,
      sort:
        sort

