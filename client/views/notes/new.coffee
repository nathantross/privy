Template.newNote.events
  "submit form": (e) ->
    e.preventDefault()
  
    note = 
      body: $(e.target).find("[name=notes-body]").val()

    Meteor.call('post', note, (error, id) -> 
      alert(error.reason) if error # need better error handling than "alerts"
    )
      
    Router.go "feed"