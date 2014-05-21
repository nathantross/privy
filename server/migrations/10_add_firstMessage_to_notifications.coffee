Migrations.add
  name: 'Add first message to notifications'
  version: 10

  up: ->
    Notifications.find().forEach (notification) ->
      firstMessage = 
        Notes.findOne(
          threadId: notification.threadId
        )

      unless firstMessage
        firstMessage = 
          Messages.findOne(
              threadId: notification.threadId
            ,
              sort:
                createdAt: 1
          )
          
      if firstMessage
        Notifications.update notification._id,
          $set:
            firstMessage: firstMessage.body
      else
        console.log "notification: #{notification._id}"

  down: ->
    Notifications.update {},
        $unset:
          firstMessage: ""
      ,
        multi: true