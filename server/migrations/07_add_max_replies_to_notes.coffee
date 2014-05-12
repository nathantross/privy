Migrations.add
  name: 'Add maxReplies attribute to notes'
  version: 7

  up: ->
    Notes.update {},
        $set:
          maxReplies: 3
      ,
        multi: true

  down: ->
    Notes.update {},
        $unset:
          maxReplies: ""
      ,
        multi: true