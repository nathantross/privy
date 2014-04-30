if Meteor.isClient
  Meteor.startup ->
    mixpanel.init "8fae59e0f1928d0b271b70446613466f"
    Deps.autorun ->
      user = Meteor.user()
      if user && !Meteor.loggingIn()
        mixpanel.identify(user._id)
        mixpanel.people.set 
          $email: user.emails[0].address