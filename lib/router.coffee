# Provide the router with the name of a loading template
Router.configure 
  layoutTemplate: "layout"
  loadingTemplate: "loading"
  # waitOn lets us load 'feed' in the background
  # until it loads fully. Giving loading template beforehand
  # waitOn: function() { return Meteor.subscribe('feed'); }


Router.map ->
  # Sets route for Index to '/' for the application
  @route "index",
    path: "/"
  

  # User Routes
  @route "register",
    path: "/register"

  @route "login",
    path: "/login"

  @route "usersEdit",
    path: "/users/:_id/edit"
    data: ->
      Meteor.users.findOne @params._id

  
  # Note Routes
  @route "feed",
    path: "/notes"

  @route "newNote",
    path: "/notes/new"

  @route "showNote",
    path: "/notes/:_id"
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
  except: ["index", "register", "terms", "privacy", "login"]