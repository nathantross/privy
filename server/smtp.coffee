# Contact Email
  sendContactEmail = ->
    # To User Email
    Email.send
      from: "Get Strange <hello@getstrange.co>"
      to: Meteor.user().emails[0].address
      subject: "Thanks for Contacting Get Strange"
      text: "We will respond to your question as soon as we can."
      html: Handlebars.templates.contact

    # To Privy Email
    Email.send
      from: "Get Strange <hello@getstrange.co>"
      to: "hello@getstrange.co"
      subject: "Contact form"
      text: "Contact Message and email"
      html: "We will respond to your question as soon as we can."

  Meteor.methods sendEmail: ->
    sendContactEmail()


# User New Note
  sendMessageNewNoteEmail = ->
    Email.send
      from: "Get Strange <hello@getstrange.co>"
      to: Meteor.user().emails[0].address
      subject: "Someone nearby has posted a note"
      text: "There is a new note near your area"
      html: "There is a new note near your area"
  Meteor.methods sendNewNoteEmail: ->
    sendMessageNewNoteEmail()


# Create Note Reminder
  sendNoteReminderEmail = ->
    Email.send
      from: "Get Strange <hello@getstrange.co>"
      to: Meteor.user().emails[0].address
      subject: "You haven't created a new note in a while"
      text: "Feel free to create a new message for our community."
      html: "Feel free to create a new message for our community."
  Meteor.methods sendReminderEmail: ->
    sendNoteReminderEmail()
