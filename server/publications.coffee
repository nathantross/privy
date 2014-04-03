# Meteor.publish "users", ->
#   Meteor.users.find()

Meteor.publish "notifications", ->
  Notifications.find userId: @userId

Meteor.publish "noteActions", ->
  NoteActions.find 
    receiverId: @userId
    isSkipped: true

Meteor.publish "notes", (options) ->
  noteIds = 
      NoteActions.find(
        isSkipped: true 
        receiverId: @userId
      ).map((na) -> na.noteId) || []
    
    Notes.find(
        _id: 
          $nin: noteIds
        isInstream: true
      , options)

Meteor.publish "threads", ->
  Threads.find
      $or:[ creatorId: @userId,
            responderId: @userId
          ]
    , 
      fields:
        createdAt: 0

Meteor.publish "contacts", ->
  threadUsers = Threads.find(
      $or:[ creatorId: @userId,
            responderId: @userId
          ]
    , 
      fields:
        creatorId: 1
        responderId: 1
    ).map( (thread) -> 
      if thread.creatorId == @userId
        thread.responderId
      else
        thread.creatorId  
    )

  Meteor.users.find
    _id:
      $in: threadUsers
    fields:
      _id: 1
      'profile.avatar': 1

Meteor.publish "messages", (threadId) ->
  Messages.find
      threadId: threadId
    ,
      fields:
        threadId: 0

  # noteIds =
  #   Notes.find( isInstream: true )
  #     .map( (n)-> n._id )

  # Threads.find(
  #   $or: [  
  #           creatorId: @userId
  #         , 
  #           responderId: @userId
  #         , _id: 
  #             $in: noteIds
  #         ]
  # )

# Meteor.publish "messages", ->
#   Messages.find()
  # threadIds = 
  #   Threads.find(
  #       $or: [  
  #           creatorId: @userId
  #         , 
  #           responderId: @userId
  #         ]).map( (t)-> t._id )
  # Messages.find
  #   threadId: 
  #     $in: threadIds






# A more secure pattern could be passing 
# the individual parameters themselves instead of 
# the whole object, to make sure you stay in control 
# of your data:
# Meteor.publish('posts', function(sort, limit) {
#   return Posts.find({}, {sort: sort, limit: limit});
# });