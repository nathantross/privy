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
      senderId: @note.userId
    
    $(e.target).find('[name=reply-body]').val('')

    Meteor.call 'addNoteReplier', noteAttr, (err, threadId) ->
      return console.log(err.reason) if err   

      reply.threadId = threadId
      Meteor.call 'readMessage', threadId, (err, id) ->
        return console.log(err.reason) if err

        Meteor.call 'createMessage', reply, (err, id) ->
          return console.log(err.reason) if err

          Meteor.call 'createNotification', reply, (err, id) ->
            console.log(err.reason) if err
    
    mixpanel.track("Reply: created", {
      noteId: @note._id, 
      body: @note.body, 
      creatorId: @note.userId, 
      threadId: @note.threadId, 
      creatorIsOnline: if !@userAttr.isIdle then "Yes" else "No"
    })

    Notify.toggleLock Session.get('currentNoteId'), false

    # document.body.style.backgroundColor = '#' + ((Math.random()*10)+1).toString(16).slice(4, 6) + 'FF' + ((Math.random()*10)+1).toString(16).slice(4, 6)

    Notify.popup('#successAlert', "Reply sent!")
             