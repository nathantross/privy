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

  Meteor.methods sendEmail: ->
    sendSampleEmail()