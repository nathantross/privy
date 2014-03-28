Meteor.publish "users", ->
  Meteor.users.find()

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
      ).map((na) -> na.noteId)

    noteIds = [] unless noteIds
    
    Notes.find(
        _id: 
          $nin: noteIds
        isInstream: true
      , options)

Meteor.publish "threads", ->
  noteIds =
    Notes.find( isInstream: true )
      .map( (n)-> n._id )

  Threads.find(
    $or: [  
            creatorId: @userId
          , 
            responderId: @userId
          , _id: 
              $in: noteIds
          ]
  )

Meteor.publish "messages", ->
  threadIds = 
    Threads.find(
        $or: [  
            creatorId: @userId
          , 
            responderId: @userId
          ]).map( (t)-> t._id )
  Messages.find
    threadId: 
      $in: threadIds






# A more secure pattern could be passing 
# the individual parameters themselves instead of 
# the whole object, to make sure you stay in control 
# of your data:
# Meteor.publish('posts', function(sort, limit) {
#   return Posts.find({}, {sort: sort, limit: limit});
# });