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

Meteor.publish "notes", (sort, limit) ->
  Notes.find
      userId:
        $ne: @userId
      isInstream: true
      $or: [
            currentViewer: @userId
          ,
            currentViewer:
              $exists: false
          ]
      replierIds:
        $ne: @userId
      skipperIds: 
        $ne: @userId
      flaggerIds:
        $ne: @userId
      $or: [
        flagCount:
          $exists: false
      , flagCount:
          $lt: 2
      ]
    , 
      sort: sort
      limit: limit
      fields: 
        skipperIds: 0
        replierIds: 0

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
        'flags.isSuspended': 1


Meteor.publish "messages", (threadId, limit) ->
  if Notify.isParticipant(@userId, threadId) 
    Messages.find
          threadId: threadId
        ,
          sort: 
            createdAt: -1
          limit: limit

  else
    null
