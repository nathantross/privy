Template.feed.events
  "click #skip": (e, template) ->   
    # e.preventDefault()
    # document.body.style.backgroundColor = '#' + ((Math.random()*10)+1).toString(16).slice(4, 6) + 'FF' + ((Math.random()*10)+1).toString(16).slice(4, 6)
    Meteor.call 'skipNote', @note._id, (error, id) -> 
      console.log(error.reason) if error

    mixpanel.track('Note: skipped', {
      noteId: @note._id, 
      body: @note.body, 
      creatorId: @note.userId, 
      creatorIsOnline: if !@userAttr.isIdle then "Yes" else "No"
    }) 
    
    Notify.toggleLock Session.get('currentNoteId'), false

  "click #startChat": ->
    $("[name=reply-body]").focus()
    mixpanel.track("Reply: clicked", {
      noteId: @note._id, 
      body: @note.body, 
      creatorId: @note.userId, 
      threadId: @note.threadId, 
      creatorIsOnline: if !@userAttr.isIdle then "Yes" else "No"
    })

  "click #flag": (e)->
    e.preventDefault()
    $('#flagAlert').slideDown "slow"
    mixpanel.track("Flag: clicked", {
      noteId: @note._id, 
      body: @note.body, 
      creatorId: @note.userId, 
      creatorIsOnline: if !@userAttr.isIdle then "Yes" else "No"
    })

Template.feed.helpers
  isUserActive: ->
    if @userAttr && !@userAttr.isIdle then "Online"