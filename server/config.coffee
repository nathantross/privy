Meteor.startup ->
  AccountsEntry.config
    # signupCode: 's3cr3t'
    defaultProfile:
      avatar: 'avatar_1.png'
      isNotified: false