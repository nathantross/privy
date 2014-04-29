Template.feed.events
  "click #skip": (e, template) ->   
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
    if @userAttr && !@userAttr.isIdle then "Online"