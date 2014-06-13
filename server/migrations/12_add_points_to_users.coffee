Migrations.add
  name: 'Add points to users'
  version: 12

  up: ->
    Meteor.users.update {},
        $set:
          'profile.points': 0
      ,
        multi: true

  down: ->
    Meteor.users.update {},
        $unset:
          'profile.points': ""
      ,
        multi: true