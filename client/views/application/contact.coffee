# Email.send({
# from: "hello@privy.cc",
# to: "nathantross@gmail.com",
# subject: "Subject",
# text: "Here is some text"
# });


if Meteor.isClient
  Template.contact.events "click #send-email": (e, tmpl) ->
    Meteor.call "sendEmail", (err) ->
      console.log err  if err


Template.contact.events "submit form": (event, template) ->
  event.preventDefault()
  firstname = template.find("input[name=firstname]")
  lastname = template.find("input[name=firstname]")
  email = template.find("input[name=email]")
  Meteor.call "sendEmail", (err) ->
  console.log err  if err
  
  # XXX Do form validation
  data =
    contactName: contactName.value
    contactEmail: contactEmail.value
    contactBody: contactBody.value

  contactEmail.value = ""
  contactName.value = ""
  contactBody.value = ""
  MyCollection.insert data, (err) -> # handle error


#   submitme = ->
#   form = {}
#   $.each $("#myform").serializeArray(), ->
#     form[@name] = @value

#   console.log "test"
#   #do validation on form={firstname:'first name', lastname: 'last name', email: 'email@email.com'}
#   MyCollection.insert form, (err) ->
#     unless err
#       alert "Submitted!"
#       $("#myform")[0].reset()
#     else
#       alert "Something is wrong"
#       console.log err

#   console.log "test2"


# Template.contact.events submit: (event) ->
# submitme()
# event.preventDefault() #prevent page refresh

# # http://stackoverflow.com/questions/15205773/submitting-a-form-in-meteor-without-using-extras