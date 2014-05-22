Migrations.add
  name: 'Add attributes to notifications'
  version: 10

  up: ->
    Notifications.find().forEach (notification) ->
      user = Meteor.users.findOne notification.userId

      # Get the originalNote
      originalNote = 
        Notes.findOne
          threadId: notification.threadId

      unless originalNote
        originalNote = 
          Messages.findOne
              threadId: notification.threadId
            ,
              sort:
                createdAt: 1

      # Find the avatarId of the partner 
      thread = Threads.findOne notification.threadId

      lastAvatarId =
        if thread.participants.length == 1
          user._id
        else if thread.participants[0].userId == user._id
          thread.participants[1].userId
        else
          thread.participants[0].userId
      
      Notifications.update notification._id,
        $set:
          originalNote: originalNote.body
          lastAvatarId: lastAvatarId
        $unset:
          lastAvatar: ""
      
  down: ->
    Notifications.update {},
        $unset:
          originalNote: ""
          lastAvatarId: ""
      ,
        multi: true