# Provide the router with the name of a loading template
Router.configure 
  layoutTemplate: "layout"
  yieldTemplates:
    'navbar':
      to: 'navRegion'
  loadingTemplate: "loading"
  notFoundTemplate: 'notFound'
  waitOn: -> 
    Meteor.subscribe 'notifications'
    Meteor.subscribe 'threads' #enables switching between threads

Router.map ->
  # Sets route for Index to '/' for the application
  @route "index",
    path: "/"
  
  # User Routes
  @route "entrySignUp",
    path: "/sign-up"

  @route "entrySignIn",
    path: "/sign-in"

  @route "resetPassword",
    path: "/resetpassword"    

  @route "editUser",
    path: "/profile/edit"

  @route "termsUrl",
    path: "/terms-of-use"

  @route "privacyUrl",
    path: "/privacy-policy"

  @route "contact",
    path: "/contact"

  @route "logout",
    path: "/"

  @route "forgotPassword",
    path: "/forgotpassword" 
  

  # Note Routes
  @route "newNote",
    path: "/notes/new"

  @route "feed",
    path: "/notes" 
    controller: FeedController
    

  # Thread Route
  @route "showThread",
    path: "/threads/:_id"
    controller: showThreadController

  @route "faq",
    path: "/faq"
  

requireLogin = -> 
  unless Meteor.user() 
    @render( if Meteor.loggingIn() then @loadingTemplate else "accessDenied" )
    @pause()
  return


Router.onBeforeAction requireLogin,
  except: ["index", "register", "termsUrl", "privacyUrl", "entrySignUp", "entrySignIn", "resetPassword", "forgotPassword"]

# Deps.autorun ->
#   if Session.get('currentThread') 
#     Meteor.subscribe('thread', Session.get('currentThread'))
