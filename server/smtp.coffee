# Contact Email
  sendContactEmail = ->
    # To User
    Email.send
      from: "Privy <hello@privy.cc>"
      to: "nathantross@gmail.com"
      subject: "Thanks for Contacting Privy"
      text: "We will respond to your question as soon as we can."
      html: Handlebars.templates.contact

    # To Privy
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
      to: "nathantross@gmail.com" #Need email
      subject: "You have a new message . . ."
      text: "You have a new message, click here to respond . . ."
      html: Handlebars.templates.messageNotification({ thread: Meteor.threadId })

  Meteor.methods sendNotificationEmail: ->
    sendMessageNotificationEmail()



# https://deploy-privy.meteor.com/threads/xMS9nw4a5NomsSX4i


# Threads.findOne(threadId).participants[userIndex].isTyping == toggle
#       threadAttr = 
#         threadId: threadId
#         toggle: toggle
#         userIndex: userIndex

# Meteor.users.findOne({_id: privy.user_id})