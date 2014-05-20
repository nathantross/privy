Template.feed.events
  "click #skip": (e, template) ->   
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
    "Online" if @userAttr? && !@userAttr.isIdle 
      
