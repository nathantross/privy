Template.newNote.events
  
  "submit form": (e) ->    
    submitNewNote()  


  "keyup #notes-body": (e)->
    if e.keyCode == 13
      e.preventDefault()
      submitNewNote()
    else
      val = $(e.target).find("[name=notes-body]").prevObject[0].value
      len = val.length
      $("#charNum").text(len + "/120")
      
      
  submitNewNote = ->
    isChecked = $('input[name=onoffswitch]').prop('checked')
    
    Meteor.call 'createThread', {}, (error, threadId) -> 
      return console.log(error.reason) if error
      
      noteAttr = 
        body: $("[name=notes-body]").val().replace(/(\r\n|\n|\r)/gm,"")
        maxReplies: parseInt($("#max-replies").val())
        threadId: threadId

      Meteor.call 'createNote', noteAttr, isChecked, (error, response) -> 
        return console.log(error.reason) if error

        # Creates new note
        message = 
          body: noteAttr.body
          threadId: response.threadId
          lastMessage: noteAttr.body
          isNewNote: true       

        Meteor.call 'createMessage', message, (error, id) ->
          return console.log(error.reason) if error 

          Meteor.call 'createNotification', message, (error, id)->
            console.log(error.reason) if error

    Notify.popup('#successAlert', "Note created! Woot woooo!")
    Router.go "feed"