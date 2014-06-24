Meteor.startup ->
  Nodetime.profile({
    accountKey: Meteor.settings.nodetimeKey, 
    appName: 'Strange'
  });

  AccountsEntry.config
    # signupCode: 's3cr3t'
    defaultProfile:
      avatar: 'avatar_1.png'
      isNotified: false