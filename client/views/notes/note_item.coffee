Template.noteItem.events
	"click #skip": (e, template) ->  	
	  e.preventDefault()

	  noteAction = noteId: template.data._id

	  Meteor.call('createNoteAction', noteAction, (error, id) -> 
	    alert(error.reason) if error # need better error handling than "alerts"
	  )
	      



# Template.noteItem.helpers

#   #...
#   upvotedClass: ->
#     userId = Meteor.userId()
#     if userId and not _.include(@upvoters, userId)
#       "btn-primary upvotable"
#     else
#       "disabled"


# Template.noteItem.events "click .upvotable": (e) ->
#   e.preventDefault()
#   Meteor.call "upvote", @_id

