if Meteor.isClient
  Meteor.startup ->
    mixpanel.init "8fae59e0f1928d0b271b70446613466f"
    Deps.autorun ->
      user = Meteor.user()
      if user && !Meteor.loggingIn()

        email =
          if user.emails?[0].address 
            user.emails[0].address 
          else if user.services?.facebook?.email
            user.services.facebook.email
        
        if email? && window.location.host != "localhost:3000"
          mixpanel.identify(user._id)
          mixpanel.people.set
            $email: email