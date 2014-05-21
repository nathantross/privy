Migrations.add
  name: 'Reset unread count'
  version: 9

  up: ->
    Meteor.users.find().forEach (user)->
      count = 0
      Threads.find(
        participants:
          $elemMatch:
            userId: user._id
          $size: 2
      ).forEach (thread)->
        msg = Messages.findOne 
            threadId: thread._id
          , sort: 
            createdAt: 1

        unless msg.isRead 
          Messages.update msg._id,
            $set:
              isRead: true

        msgs = 
          Messages.find(
            threadId: thread._id
            isRead: false
            senderId: 
              $ne: user._id
          )

        if msgs.count() > 0
          console.log msgs.fetch()
          count += msgs



      Meteor.users.update user._id,
        $set:
          'notifications.0.count': count

  down: ->
    Meteor.users.update {}
      , $set:
        'notifications.0.count': 0
      , {multi: true}
