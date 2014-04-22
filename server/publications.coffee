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
      skipperIds: 
        $ne: @userId
    , 
      sort: sort
      limit: limit
      fields: 
        skipperIds: 0

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
  if Notify.isParticipant(@userId, threadId) 
    Messages.find
          threadId: threadId
        ,
          sort:
            sort
  else
    null
