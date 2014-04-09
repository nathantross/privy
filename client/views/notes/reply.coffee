Template.noteReply.events
  "submit form": (e, template) ->
    e.preventDefault()

    # Set Note's isInstream to false
    noteId = @note._id

    Meteor.call('removeNoteFromStream', noteId, (error, id) ->
      if error 
        alert(error.reason)  # need better error handling  
      else
        # Update the thread's responderId
        Meteor.call('addParticipant', noteId, (error, id) ->
          if error
            alert(error.reason) 
          else
            # Create a message
            $body = $(e.target).find('[name=reply-body]')
            reply = 
              body: $body.val()
              noteId: noteId

            Meteor.call('createMessage', reply, (error, id) ->
              alert(error.reason) if error # need better error handling  
            )
            $(e.target).find('[name=reply-body]').val('')
        )
    )

  "keydown form": (e, template) ->
    