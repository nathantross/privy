Template.noteReply.events
  "submit form": (e, template) ->
    e.preventDefault()

    # Set Note's isInstream to false
    noteId = template.data._id

    Meteor.call('removeNoteFromStream', noteId, (error, noteId) ->
      if error 
        alert(error.reason)  # need better error handling  
      else
        # Update the thread's responderId
        threadId = Threads.findOne(noteId: noteId)._id
        Meteor.call('updateResponder', threadId, (error, id) ->
          alert(error.reason) if error # need better error handling  
        )
    
        # Create a message
        $body = $(e.target).find('[name=reply-body]')
        reply = 
          body: $body.val()
          threadId: threadId

        Meteor.call('createMessage', reply, (error, id) ->
          alert(error.reason) if error # need better error handling  
        )

        $body.val("") 
    )
    # TODO update dom?
    