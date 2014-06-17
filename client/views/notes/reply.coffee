Template.noteReply.events
  "submit form": (e, template) ->
    e.preventDefault()

    # Set Note's isInstream to false
    noteAttr = 
      noteId: @note._id
      threadId: @note.threadId
      senderId: @note.userId
      createdAt: @note.createdAt
      body: @note.body

    $body = $(e.target).find('[name=reply-body]')

    reply = 
      body: $body.val()
      lastMessage: $body.val()
      isReply: true
      noteCreatorId: @note.userId
      originalNote: @note.body
    
    $(e.target).find('[name=reply-body]').val('')

    Meteor.call 'addNoteReplier', noteAttr, (err, threadId) ->
      return console.log(err.reason) if err   

      reply.threadId = threadId
      
      Meteor.call 'createMessage', reply, (err, id) ->
        return console.log(err.reason) if err

        console.log "testing123"
        # Meteor.call 'createNotification', reply, (err, id) ->
        #   console.log(err.reason) if err

        # Meteor.call 'readMessage', reply.threadId, (err, id) ->
        #   return console.log(err.reason) if err
    
    mixpanel.track("Reply: created", {
      noteId: @note._id, 
      body: @note.body, 
      creatorId: @note.userId, 
      threadId: @note.threadId, 
      creatorIsOnline: if !@userAttr.isIdle then "Yes" else "No"
    })

    # Notify.toggleLock Session.get('currentNoteId'), false

    Notify.popup('#successAlert', "Reply sent!")
             