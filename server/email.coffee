# User Email Verification on Creation
Accounts.config
  sendVerificationEmail: true
  forbidClientAccountCreation: false
  Accounts.emailTemplates.siteName = "Get Strange"
  Accounts.emailTemplates.from = "Get Strange <hello@getstrange.co>"

  Accounts.emailTemplates.verifyEmail.subject = (user) ->
    "Verify your account on Get Strange"
  
  Accounts.emailTemplates.verifyEmail.text = (user, url) ->
    "Thanks for joining Strange!\n\nTo finish verifying your anonymous account on Get Strange, please click the link below:\n\n" + url

