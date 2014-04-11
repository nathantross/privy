Meteor.publish "userStatus", ->
  if @userId
    UserStatus.connections.find
        userId: @userId
      ,
        fields: 
          userId: 1
          idle: 1
  else
    @ready()

Meteor.publish "notifications", ->
  if @userId
    Notifications.find userId: @userId,
      sort:
        updatedAt: -1
  else
    @ready()

Meteor.publish "noteActions", ->
  if @userId
    noteIds = 
      Notes.find( 
        isInstream: true
      ).map((n) -> n._id)

    NoteActions.find 
      noteId:
        $in: noteIds
      receiverId: @userId
      isSkipped: true
  else
    @ready()

Meteor.publish "notes", (options) ->
  if @userId
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
  else
    @ready()

Meteor.publish "threads", ->
  if @userId
    Threads.find
        participants:
          $elemMatch:
            userId: @userId
      , 
        fields:
          createdAt: 0
          noteId: 0
  else
    @ready()

# Meteor.publish "thread", (threadId) ->
#   Threads.find
#       _id: threadId
#     ,
#       fields:
#         createdAt: 0
#         updatedAt: 0
#         noteId: 0
#       limit: 1

Meteor.publish "userData", ->
  if @userId
    Meteor.users.find
      _id: @userId
    ,
      fields:
        notifications: 1
        status: 1
  else
    @ready()


Meteor.publish "messages", (threadId, sort) ->
  if @userId
    Messages.find
        threadId: threadId
      ,
        sort:
          sort
  else
    @ready()

