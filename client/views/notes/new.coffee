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
              lastMessage: note.body 

            Meteor.call('createMessage', message, (error, id)->
              if error
                alert(error.reason) 
              else
                Meteor.call('createNotification', message, (error, id)->
                  alert(error.reason) if error
                )
            )
        )
    )

    Router.go "feed"

  "keyup input": (e)->
      val = $(e.target).find("[name=notes-body]").prevObject[0].value
      len = val.length
      $("#charNum").text(len + "/65")
