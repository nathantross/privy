# Provide the router with the name of a loading template
Router.configure 
  layoutTemplate: "layout"
  # waitOn lets us load 'feed' in the background
  # until it loads fully. Giving loading template beforehand
  # loadingTemplate: 'loading',
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
  @route "notes",
    path: "/notes"

  @route "notesNew",
    path: "/notes/new"

  @route "notesShow",
    path: "/notes/:_id"
    data: ->
      Notes.findOne @params._id

  @route "notesSubimt",
    path: "notes/submit"

  @route "notesEdit",
    path: "/notes/:_id/edit"
    data: ->
      Notes.findOne @params._id

  @route "notesDestroy",
    path: "/notes/:_id/destroy"
    data: ->
      Notes.findOne @params._id

  
  # Thread Route
  @route "threadsId",
    path: "/threads/:_id"
    data: ->
      Threads.findOne @params._id

  
  # Various Routes
  @route "privacyPolicy",
    path: "/privacy-policy"

  @route "termsConditions",
    path: "/terms-conditions"

  @route "faqs",
    path: "/faqs"
