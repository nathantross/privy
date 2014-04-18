Migrations.add(
  name: 'Users can manipulate their notifications.'
  version: 3

  up: ->
    Meteor.users.find().forEach( (user)->
      threadIds = Threads.find(
        participants:
          $elemMatch:
            userId: user._id
        ).map((t) -> t._id)

      count = 0
      for threadId in threadIds
        count += Messages.find(
          threadId: threadId
          senderId: 
            $ne: user._id
          isRead: false
        ).count()

      Meteor.users.update(
          user._id
        ,
          $addToSet:
            notifications:
              $each: [
                count: count
                email: true
                sound: true
                sms: true
                isTitleFlashing: false
                isNavNotified: user.profile.isNotified
              ]
          $unset:
            'profile.isNotified': ""
        ,
          multi: true
      )
  )

  down: ->
    Meteor.users.find().forEach( (user)->
      Meteor.users.update(
          user._id
        ,
          $set:
            'profile.isNotified': user.notifications.isNavNotified
          $unset:
            notifications: ""
        ,
          multi: true
      )
    )
)      
