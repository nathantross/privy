# Provide the router with the name of a loading template
Router.configure 
  layoutTemplate: "layout"
  yieldTemplates:
    'navbar':
      to: 'navRegion'
  loadingTemplate: "loading"
  notFoundTemplate: 'notFound'
  waitOn: -> 
    [Meteor.subscribe 'notifications']

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

  @route "logout",
    path: "/"

  @route "forgotPassword",
    path: "/forgotpassword" 
  

  # Note Routes
  @route "newNote",
    path: "/notes/new"

  # @route "showNote",
  #   path: "/notes/list/:_id"
  #   data: ->
  #     Notes.findOne @params._id

  # @route "editNote",
  #   path: "/notes/:_id/edit"
  #   data: ->
  #     Notes.findOne @params._id

  # @route "destroyNote",
  #   path: "/notes/:_id/destroy"
  #   data: ->
  #     Notes.findOne @params._id

  @route "feed",
    path: "/notes/:notesLimit?" 
    controller: FeedController
    

  # Thread Route
  @route "showThread",
    path: "/threads/:_id"
    data: ->
      Threads.findOne @params._id


  @route "faq",
    path: "/faq"
  

requireLogin = -> 
  unless Meteor.user() 
    @render( if Meteor.loggingIn() then @loadingTemplate else "accessDenied" )
    @stop()
  return

Router.onBeforeAction requireLogin,
  except: ["index", "register", "termsUrl", "privacyUrl", "entrySignUp", "entrySignIn", "resetPassword", "forgotPassword"]

