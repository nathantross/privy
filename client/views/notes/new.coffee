Template.newNote.events
  
  "submit form": (e) ->    
    submitNewNote(e)  


  "keyup #notes-body": (e)->
    if e.keyCode == 13
      e.preventDefault()
      submitNewNote()
    else
      val = $(e.target).find("[name=notes-body]").prevObject[0].value
      len = val.length
      $("#charNum").text(len + "/120")

      if window.innerWidth < 480
        lineHeight = if len > 90 then '25px' else ''
        $("#notes-body").css('line-height', lineHeight) 
      
      
  submitNewNote = (e) ->
    body = $("[name=notes-body]").val().replace(/(\r\n|\n|\r)/gm,"")

    if body.length > 0
      Notify.popup('#successAlert', "Note created! Woot woooo!")
      isChecked = $('input[name=onoffswitch]').prop('checked')
      
      Meteor.call 'createThread', {}, (error, threadId) -> 
        return console.log(error.reason) if error
        
        noteAttr = 
          body: body
          # maxReplies: parseInt($("#max-replies").val())
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

      Router.go "feed"

    else
      e.preventDefault()
      Notify.popup "#errorAlert", "Whoops! Looks like your note's blank."