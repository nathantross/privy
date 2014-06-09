Migrations.add
  name: 'Unset currentViewer from notes'
  version: 11

  up: ->
    Notes.update {}, 
        $unset:
          currentViewer: ""
      ,
        multi: true

  down: ->
