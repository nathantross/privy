Template.feed.events
  "click #skip": (e, template) ->   
    e.preventDefault()
    noteAction = noteId: @note._id
    Meteor.call('createNoteAction', noteAction, (error, id) -> 
      alert(error.reason) if error # need better error handling than "alerts"
    ) 