# Contact Email
  sendContactEmail = ->
    # To User Email
    Email.send
      from: "Privy <hello@privy.cc>"
      to: Meteor.user().emails[0].address
      subject: "Thanks for Contacting Privy"
      text: "We will respond to your question as soon as we can."
      html: Handlebars.templates.contact

    # To Privy Email
    Email.send
      from: "Privy <hello@privy.cc>"
      to: "hello@privy.cc"
      subject: "Contact form"
      text: "Contact Message and email"
      html: "We will respond to your question as soon as we can."

  Meteor.methods sendEmail: ->
    sendContactEmail()


# Message Reply Email
  sendMessageNotificationEmail = (emailAttr) ->
    Email.send
      from: "Privy <hello@privy.cc>"
      to: emailAttr.receiverEmail
      subject: "You have a new message . . ."
      text: "You have a new message, click here to respond . . ."
      html: emailAttr.receiverEmail + emailAttr.senderAvatar + emailAttr.threadId + emailAttr.lastMessage
      
  Meteor.methods sendNotificationEmail: (emailAttr) ->
    unless emailAttr.receiverEmail
      throw new Meteor.Error(404, "Receiver Email does not exist.")

    unless emailAttr.senderAvatar
      throw new Meteor.Error(404, "Sender Avatar does not exist.")
    
    unless emailAttr.threadId
      throw new Meteor.Error(404, "Thread Id does not exist.")

    unless emailAttr.lastMessage
      throw new Meteor.Error(404, "Last Message does not exist.")

    sendMessageNotificationEmail(emailAttr)


# User New Note
  sendMessageNewNoteEmail = ->
    Email.send
      from: "Privy <hello@privy.cc>"
      to: Meteor.user().emails[0].address
      subject: "Someone nearby has posted a note"
      text: "There is a new note near your area"
      html: "There is a new note near your area"
  Meteor.methods sendNewNoteEmail: ->
    sendMessageNewNoteEmail()


# Create Note Reminder
  sendNoteReminderEmail = ->
    Email.send
      from: "Privy <hello@privy.cc>"
      to: Meteor.user().emails[0].address
      subject: "You haven't created a new note in a while"
      text: "Feel free to create a new message for our community."
      html: "Feel free to create a new message for our community."
  Meteor.methods sendReminderEmail: ->
    sendNoteReminderEmail()




# Threads.findOne(threadId).participants[userIndex].isTyping == toggle
#       threadAttr = 
#         threadId: threadId
#         toggle: toggle
#         userIndex: userIndex

# Meteor.users.findOne({_id: privy.user_id})