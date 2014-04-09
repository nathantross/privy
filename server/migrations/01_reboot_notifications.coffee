Migrations.add(
  name: 'Notifications are given a new schema.'
  version: 1

  up: ->
    Notifications.remove({})
    console.log("Number of notifications:" + Notifications.find().count())

    Threads.find().forEach (thread) ->
      
      # find the last message
      lastMessage = Messages.find(
          threadId: thread._id
        ,
          sort:
            updatedAt: -1
          limit: 1
        ).fetch()[0]
        
      # send a notification to each person on each thread
      participantIds = []
      participantIds[0] = thread.creatorId
      participantIds[1] = thread.responderId if thread.responderId

      # set the notificaiton avatar to the other person's avatar
      for participantId in participantIds
        avatarId =
          if thread.responderId && participantId == thread.creatorId
            thread.responderId
          else
            thread.creatorId

        avatar = Meteor.users.findOne(avatarId).profile['avatar']

        # create the notifications
        Notifications.insert
          userId: participantId
          threadId: thread._id
          lastMessage: lastMessage.body
          lastAvatar: avatar
          isNotified: false
          createdAt: lastMessage.createdAt
          updatedAt: lastMessage.createdAt

  down: ->
    Notifications.update {}, 
        $unset: 
          lastMessageId: ""
          lastMessage: ""
          lastAvatar: ""
      , 
        multi: true
)