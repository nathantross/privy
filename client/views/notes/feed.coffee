Template.feed.events
  "click #skip": (e, template) ->   
    e.preventDefault()
    document.body.style.backgroundColor = '#' + ((Math.random()*10)+1).toString(16).slice(4, 6) + 'FF' + ((Math.random()*10)+1).toString(16).slice(4, 6)
    Meteor.call 'skipNote', @note._id, (error, id) -> 
      alert(error.reason) if error # need better error handling than "alerts"
    Notify.toggleLock Session.get('currentNoteId'), false

  "click #startChat": ->
    $("[name=reply-body]").focus()

Template.feed.helpers
  isUserActive: ->
    if @userAttr && @userAttr.isIdle then "Online" else "Not online"