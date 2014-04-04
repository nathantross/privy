Template.contact.events "click #send-email": (e, tmpl) ->
Meteor.call("sendEmail")
(err) ->
  console.log err  if err