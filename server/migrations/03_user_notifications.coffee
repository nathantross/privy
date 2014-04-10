Migrations.add(
  name: 'Users can manipulate their notifications.'
  version: 3

  up: ->
    Meteor.users.find().forEach( (user)->
      count = Notifications.find(
        userId: user._id
        isNotified: true
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
