# Provide the router with the name of a loading template
Router.configure 
  layoutTemplate: "layout"
  loadingTemplate: "loading"
  notFoundTemplate: 'notFound'
  waitOn: -> 
    [Meteor.subscribe 'notifications']

Router.map ->
  # Sets route for Index to '/' for the application
  @route "index",
    path: "/"
  
  # User Routes
  @route "register",
    path: "/register"

  @route "login",
    path: "/login"

  @route "resetPassword",
    path: "/resetpassword"    

  @route "editUser",
    path: "/profile/edit"

  @route "logout",
    path: "/"

  @route "forgotPassword",
    path: "/forgotpassword" 
  

  # Note Routes
  @route "newNote",
    path: "/notes/new"

  @route "showNote",
    path: "/notes/list/:_id"
    data: ->
      Notes.findOne @params._id

  @route "editNote",
    path: "/notes/:_id/edit"
    data: ->
      Notes.findOne @params._id

  @route "destroyNote",
    path: "/notes/:_id/destroy"
    data: ->
      Notes.findOne @params._id

  @route "feed",
    path: "/notes/:notesLimit?" 
    controller: FeedController
  

  # Thread Route
  @route "showThread",
    path: "/threads/:_id"
    data: ->
      Threads.findOne @params._id


  # Various Routes
  @route "privacy",
    path: "/privacy"

  @route "terms",
    path: "/terms"

  @route "faq",
    path: "/faq"
  

requireLogin = -> 
  unless Meteor.user() 
    @render( if Meteor.loggingIn() then @loadingTemplate else "accessDenied" )
    @stop()
  return

Router.before requireLogin,
  except: ["index", "register", "terms", "privacy", "login", "resetPassword", "forgotPassword"]

