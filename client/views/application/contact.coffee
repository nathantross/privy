Template.contact.events "click #send-email": (e, tmpl) ->
  Meteor.call "sendEmail", (err) ->
  	console.log err  if err


Template.contact.events "submit form": (event, template) ->
  event.preventDefault()
  Meteor.call "sendEmail", (err) ->
  	console.log err  if err