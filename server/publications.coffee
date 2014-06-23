# QUERIES AND OPTIONS -------------------------------------

noteQuery = (userId) ->
  user = Meteor.users.findOne userId

  return(
    $and: [
            userId:
              $ne: userId
          , userId:
              $nin: user.blockerIds || []
          ]
    isInstream: true
    # $or: [
    #       currentViewer: userId
    #     , currentViewer:
    #         $exists: false
    #     ]
    replierIds:
      $ne: userId
    skipperIds: 
      $ne: userId
    flaggerIds:
      $ne: userId
    $or: [
      flagCount:
        $exists: false
    , flagCount:
        $lt: 2
    ]
  )

noteOptions =
  sort: 
    createdAt: -1
  limit: 5
  fields: 
    skipperIds: 0
    replierIds: 0
    loc: 0

notificationsQuery = (userId) ->
  userId: userId
  $or: [
        isBlocked: false
      , isBlocked:
          $exists: false
      ]
  isArchived: false

notificationsOptions =   
  limit: 15
  sort:
    updatedAt: -1

threadsOptions =
  fields:
    createdAt: 0
    noteId: 0

userStatusOptions = 
  fields: 
    'profile.avatar': 1
    'profile.points': 1
    'status.online': 1
    'status.idle': 1

messageOptions = (limit) ->
  limit: limit
  sort:
    createdAt: -1 

# PUBLICATIONS -------------------------------------

Meteor.publish "userData", ->
  Meteor.users.find
      _id: @userId
    ,
      limit: 1
      fields:
        notifications: 1
        status: 1
        inThreads: 1
        'flags.isSuspended': 1
        blockedIds: 1

Meteor.publish "notificationsData", ->
  if @userId
    Meteor.publishWithRelations
      handle: @
      collection: Notifications
      filter: notificationsQuery(@userId)
      options: notificationsOptions
      mappings: [
        {
          key: "lastAvatarId"
          collection: Meteor.users
          options: userStatusOptions
        }, {
          key: "threadId"
          collection: Threads
          filter: {}
          options: threadsOptions
          mappings: [
            {
              reverse: true
              key: "threadId"
              collection: Messages
              filter: {}
              options: messageOptions(10)
            }
          ]
        }

        {
          key:        "threadId"
          collection: Notifications
          filter:     notificationsQuery(@userId)
          options:    notificationsOptions
        }
      ]

Meteor.publish "notesData", ->
  if @userId
    Meteor.publishWithRelations
        handle: @
        collection: Notes
        filter: noteQuery(@userId)
        options: noteOptions
        mappings: [
          {
            key: "userId"
            collection: Meteor.users
            filter: {}
            options: userStatusOptions
        }]

Meteor.publish "moreMessages", (threadId, limit) ->
  if @userId
    participants = Notify.getParticipants(threadId)
    if participants[0].userId == @userId || participants[1].userId == @userId
      Messages.find
          threadId: threadId
        ,
          sort: 
            createdAt: -1
          limit: limit

    else
      null


# OLD PUBLICATIONS --------------------------------

# Meteor.publish "userStatus", ->
#   UserStatus.connections.find
#         userId: @userId
#       ,
#         fields: 
#           userId: 1
#           idle: 1

# Meteor.publish "notificationUserStatus", ->
#   if @userId
#     Meteor.publishWithRelations
#       handle: @
#       collection: Meteor.users
#       options: 
#         fields: 
#           'profile.avatar': 1
#           'profile.points': 1
#           'status.online': 1
#           'status.idle': 1
#       filter: {}
#       mappings: [
#         {
#           key:        "userId"
#           collection: Notes
#           filter:     noteQuery(@userId)
#           options:    noteOptions

#         }
#         {
#           key:        "lastAvatarId"
#           collection: Notifications
#           filter:     notificationsQuery(@userId)
#           options:    notificationsOptions
#         }
#       ]

# Meteor.publish "manyThreads", ->
#   if @userId
#     Meteor.publishWithRelations
#       handle: @
#       collection: Threads
#       options: 
#         fields: 
#           'createdAt': 0
#           'noteId': 0
#       filter: {}
#       mappings: [
#         {
#           key:        "threadId"
#           collection: Notifications
#           filter:     notificationsQuery(@userId)
#           options:    notificationsOptions
#         }
#       ]


# Meteor.publish "userStatus", ->
#   if @userId
#     Meteor.publishWithRelations
#       handle: @
#       collection: Meteor.users
#       options: 
#         fields: 
#           'profile.avatar': 1
#           'profile.points': 1
#           'status.online': 1
#           'status.idle': 1
#       filter: {}
#       mappings: [
#         {
#           key:        "userId"
#           collection: Notes
#           filter:     noteQuery(@userId)
#           options:    noteOptions

#         }
#         {
#           key:        "lastAvatarId"
#           collection: Notifications
#           filter:     notificationsQuery(@userId)
#           options:    notificationsOptions
#         }
#       ]

# Meteor.publish "notifications", ->
#   Notifications.find notificationsQuery(@userId), notificationsOptions


# Meteor.publish "notes", (sort, limit) ->
#   if @userId
#     user = Meteor.users.findOne @userId
#     Notes.find noteQuery(@userId), noteOptions


# Meteor.publish "oneThread", (threadId) ->
#   if @userId
#     participants = Notify.getParticipants(threadId)
#     if participants[0].userId == @userId || participants[1].userId == @userId
#       Threads.find
#           _id: threadId
#         , 
#           limit: 1
#           fields:
#             createdAt: 0
#             noteId: 0
