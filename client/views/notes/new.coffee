Template.newNote.events
  "submit form": (e) ->
    e.preventDefault()
  
    note = 
      body: $(e.target).find("[name=notes-body]").val()
      userId: Meteor.userId()
      isInstream: true

    note._id = Notes.insert(note)
    Router.go "index"