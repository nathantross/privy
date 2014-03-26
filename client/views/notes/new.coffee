Template.newNote.events
  "submit form": (e) ->
    e.preventDefault()
    
    # Creates new note
    note = 
      body: $(e.target).find("[name=notes-body]").val()

    Meteor.call('createNote', note, (error, id) -> 
      if error 
        alert(error.reason) 
      else 
        thread = 
          noteId: id

        Meteor.call('createThread', thread, (error, id) -> 
          if error 
            alert(error.reason)
          else 
            message = 
              body: note.body
              threadId: id

            Meteor.call('createMessage', message, (error, id)->
              alert(error.reason) if error
            )
        )
    )

    Router.go "feed"
