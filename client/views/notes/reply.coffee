Template.noteReply.events
  "submit form": (e, template) ->
    e.preventDefault()

    # Set Note's isInstream to false
    noteId = template.data._id
    
    Meteor.call('switchInstream', noteId, (error, id) ->
      alert(error.reason) if error # need better error handling  
    )

    # Create a message
    $body = $(e.target).find('[name=reply-body]')
    # reply = 
    #   body: $body.val()
    #   threadId: Threads.findOne(noteId: noteId)._id

    # Meteor.call('createReply', reply, (error, id) ->
    #   alert(error.reason) if error # need better error handling  
    # )
    $body.val("") 

    # TODO update dom?
    

    