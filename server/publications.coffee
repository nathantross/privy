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

oneNoteOptions = 
  limit: 1
  sort: 
    userId: 1
  fields: 
    body: 1
    threadId: 1
    userId: 1
    place: 1

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

userDataOptions = 
  limit: 1
  fields:
    notifications: 1
    status: 1
    inThreads: 1
    'flags.isSuspended': 1
    blockedIds: 1

# PUBLICATIONS -------------------------------------

Meteor.publish "userData", ->
  Meteor.users.find { _id: @userId }, userDataOptions

Meteor.publish "chatsData", ->
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
      Messages.find { threadId: threadId }, messageOptions(limit) 

Meteor.publish "oneNote", (noteId) ->
  Meteor.publishWithRelations
    handle: @
    collection: Notes
    filter: noteId
    options: oneNoteOptions
    mappings: [
      {
        key: "userId"
        collection: Meteor.users
        filter: {}
        options: userStatusOptions
    }]
