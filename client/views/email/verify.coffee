Accounts.emailTemplates.siteName = "AwesomeSite"
Accounts.emailTemplates.from = "AwesomeSite Admin <accounts@example.com>"
Accounts.emailTemplates.enrollAccount.subject = (user) ->
  "Welcome to Awesome Town, " + user.profile.name

Accounts.emailTemplates.enrollAccount.text = (user, url) ->
  "You have been selected to participate in building a better future!" + " To activate your account, simply click the link below:\n\n" + url
