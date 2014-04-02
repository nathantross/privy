# Template.noteItem.events
#   "click #skip": (e, template) ->   
#     e.preventDefault()
#     noteAction = noteId: template.data._id
#     Meteor.call('createNoteAction', noteAction, (error, id) -> 
#       alert(error.reason) if error # need better error handling than "alerts"
#     ) 
#     Router.go @route.path(notesLimit: @limit() + @increment)
