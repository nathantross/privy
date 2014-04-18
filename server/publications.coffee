Meteor.publish "userStatus", ->
  UserStatus.connections.find
        userId: @userId
      ,
        fields: 
          userId: 1
          idle: 1

Meteor.publish "notifications", ->
  Notifications.find userId: @userId,
      sort:
        updatedAt: -1

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
          userId:
            $ne: @userId
          isInstream: true
        , options

Meteor.publish "threads", ->
  Threads.find
        participants:
          $elemMatch:
            userId: @userId
      , 
        fields:
          createdAt: 0
          noteId: 0

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
  Meteor.users.find
      _id: @userId
    ,
      fields:
        notifications: 1
        status: 1
        inThreads: 1


Meteor.publish "messages", (threadId, sort) ->
  Messages.find
        threadId: threadId
      ,
        sort:
          sort

