Migrations.add
  name: 'Add isArchived to all notifications'
  version: 8

  up: ->
    Notifications.update {},
        $set:
          isArchived: false
      ,
        multi: true

  down: ->
    Notifications.update {},
        $unset:
          isArchived: ""
      ,
        multi: true