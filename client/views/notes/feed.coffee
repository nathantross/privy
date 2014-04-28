Template.feed.events
  "click #skip": (e, template) ->   
    # e.preventDefault()
    # document.body.style.backgroundColor = '#' + ((Math.random()*10)+1).toString(16).slice(4, 6) + 'FF' + ((Math.random()*10)+1).toString(16).slice(4, 6)
    Meteor.call 'skipNote', @note._id, (error, id) -> 
      console.log(error.reason) if error
    Notify.toggleLock Session.get('currentNoteId'), false

  "click #startChat": ->
    $("[name=reply-body]").focus()

  "click #flag": (e)->
    e.preventDefault()
    $('#flagAlert').slideDown "slow"

Template.feed.helpers
  isUserActive: ->
    if @userAttr && @userAttr.isIdle then "Online" else "Not online"