Migrations.add
  name: 'Email added to users who logged in with Facebook'
  version: 6

  up: ->
    Meteor.users.find().forEach (user)->
      if user.services?.facebook?.email
        Meteor.users.update user._id,
          $addToSet:
              emails:
                $each: [
                  'address': user.services.facebook.email
                  'verified': true
                ]
  
  down: ->
    Meteor.users.find().forEach (user)->
      if user.services?.facebook?.email
        Meteor.users.update user._id,
          $unset:
            'emails[0].address': ""
            'emails[0].verified': ""
          