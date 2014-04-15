# Email Template Testing
#	Email.send
#	  from: "hello@privy.cc"
#	  to: "nathantross@gmail.com"
#	  subject: "Meteor Can Send Emails via Gmail"
#	  text: "Its pretty easy to send emails via gmail."



  # Contact Email
  sendContactEmail = ->
    Email.send
      from: "Privy <hello@privy.cc>"
      to: "nathantross@gmail.com"
      subject: "Thanks for Contacting Privy"
      text: "We will respond to your question as soon as we can."
      html: "<p>We will respond to your question as soon as we can.</p>"

    Email.send
      from: "Privy <hello@privy.cc>"
      to: "hello@privy.cc"
      subject: "Contact form"
      text: "Contact Message and email"

  Meteor.methods sendEmail: ->
    sendContactEmail()


  # Message Reply Email
  sendMessageNotificationEmail = ->
    Email.send
      from: "Privy <hello@privy.cc>"
      to: "nathantross@gmail.com"
      subject: "You have a new message . . ."
      text: "You have a new message, click here to respond . . ."
      html: Handlebars.templates.messageNotification({ message: Meteor.userId })

  Meteor.methods sendNotificationEmail: ->
    sendMessageNotificationEmail()













