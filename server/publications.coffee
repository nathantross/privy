Meteor.publish "userStatus", ->
  UserStatus.connections.find
        userId: @userId
      ,
        fields: 
          userId: 1
          idle: 1

Meteor.publish "notificationUserStatus", ->
  userIds = 
    Threads.find(
      participants:
        $elemMatch:
          userId: @userId
    ).map( (thread) -> 
      if thread.participants.length == 2
        [thread.participants[0].userId, thread.participants[1].userId]
      else
        thread.participants[0].userId
    )

  Meteor.users.find
      _id: 
        $in: _.uniq(_.flatten(userIds))
    ,
      fields: 
        'profile.avatar': 1
        'status.online': 1
        'status.idle': 1

Meteor.publish "notifications", ->
  Notifications.find 
      userId: @userId
      $or: [
            isBlocked: false
          , isBlocked:
              $exists: false
          ]
      isArchived: false
    , sort:
        updatedAt: -1

Meteor.publish "notes", (sort, limit) ->
  if @userId
    user = Meteor.users.findOne @userId
    
    Notes.find
        $and: [
          userId:
            $ne: @userId
        , userId:
            $nin: user.blockerIds || []
        , userId:
            $nin: user.blockedIds || []
        ]
        isInstream: true
        $or: [
              currentViewer: @userId
            , currentViewer:
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
          loc: 0

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
        blockedIds: 1


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
