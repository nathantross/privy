Templates.newNotes.events
  "submit form": (e) ->
    e.preventDefault()
  
  note = 
    body: $(e.target).find("[name=notes-body").val()
    userId: 

  note._id = Notes.insert(note, )
  Router.go "notesShow"