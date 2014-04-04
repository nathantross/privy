# Accounts-Password Verification
Accounts.config
  sendVerificationEmail: true
  forbidClientAccountCreation: false



# Contact Email Message to user
sendSampleEmail = ->
Email.send
  from: "Privy <hello@privy.cc>"
  to: "nathantross@gmail.com"
  subject: "Thanks for contacting us"
  text: "Thank you for contacting us. We will respond to your question as soon as we can. -The Privy Team"
  html: "<h2>Thank you for contacting us.</h2>
  		<br>
  		<p>We will respond to your question as soon as we can.</p>
  		<br>
  		<p>The Privy Team</p>"

# Contact Email Message Response to Privy Team
Email.send
  from: "Nathan <nathantross@gmail.com>"
  to: "hello@privy.cc"
  subject: "Contact"
  text: "This is a contact message"
  html: "This is a contact message"


Meteor.methods sendEmail: ->
sendSampleEmail()