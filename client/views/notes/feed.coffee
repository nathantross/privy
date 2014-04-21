Template.feed.events
  "click #skip": (e, template) ->   
    e.preventDefault()
    document.body.style.backgroundColor = '#' + ((Math.random()*10)+1).toString(16).slice(4, 6) + 'FF' + ((Math.random()*10)+1).toString(16).slice(4, 6)
    noteAction = noteId: @note._id
    Meteor.call 'createNoteAction', noteAction, (error, id) -> 
      alert(error.reason) if error # need better error handling than "alerts"

  "click #startChat": ->
    $("[name=notes-body]").focus();