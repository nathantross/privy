# User Email Verification on Creation
Accounts.config
  sendVerificationEmail: true
  forbidClientAccountCreation: false
  Accounts.emailTemplates.siteName = "Privy"
  Accounts.emailTemplates.from = "Privy <hello@privy.cc>"
  Accounts.emailTemplates.verifyEmail.subject = (user) ->
    "Verify your Privy Account"
  Accounts.emailTemplates.verifyEmail.text = (user, url) ->
    "Thinks for joining Privy!\n\nTo finish verifying your anonymous Privy account, please click the link below:\n\n" + url

