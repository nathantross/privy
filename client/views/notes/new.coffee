Template.newNote.events

  "submit form": (e) ->
    e.preventDefault()
    isChecked = $('input[name=onoffswitch]').prop('checked')

    Meteor.call 'createThread', {}, (error, threadId) -> 
      return console.log(error.reason) if error
      
      noteAttr = 
        body: $(e.target).find("[name=notes-body]").val()
        maxReplies: parseInt($(e.target).find("#max-replies").val())
        threadId: threadId

      Meteor.call 'createNote', noteAttr, isChecked, (error, response) -> 
        return console.log(error.reason) if error

        # Creates new note
        message = 
          body: noteAttr.body
          threadId: response.threadId
          lastMessage: noteAttr.body       

        Meteor.call 'createMessage', message, (error, id) ->
          return console.log(error.reason) if error 

          Meteor.call 'createNotification', message, (error, id)->
            console.log(error.reason) if error

    Notify.popup('#successAlert', "Note created! Woot woooo!")
    Router.go "feed"

  'click #myonoffswitch': (e)->
    isChecked = $('input[name=onoffswitch]').prop('checked')
    
    if isChecked
      #Get the latitude and the longitude;
      successFunction = (position) ->
        Session.set('lat', position.coords.latitude)
        Session.set('lng', position.coords.longitude)

      errorFunction = ->
        console.log  "Geocoder failed"
      
      if navigator.geolocation
        navigator.geolocation.getCurrentPosition successFunction, errorFunction  

  "keyup #notes-body": (e)->
      val = $(e.target).find("[name=notes-body]").prevObject[0].value
      len = val.length
      $("#charNum").text(len + "/120")
