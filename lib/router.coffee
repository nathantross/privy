# Provide the router with the name of a loading template
Router.configure 
  layoutTemplate: "layout"
  loadingTemplate: "loading"
  # waitOn lets us load 'feed' in the background
  # until it loads fully. Giving loading template beforehand
  # waitOn: function() { return ('index'); }
  # waitOn: -> 
  #   [Meteor.subscribe 'notifications']

FeedController = RouteController.extend(
  template: "feed"
  increment: 1
  limit: ->
    parseInt(@params.notesLimit) || @increment

  findOptions: ->
    sort:
      submitted: -1
    limit: @limit()

  waitOn: ->
    Meteor.subscribe "notes", @findOptions()

  notes: ->
    Notes.find isInstream: true, @findOptions()

  data: ->
    hasMore = @notes().fetch().length is @limit()
    nextPath = @route.path(notesLimit: @limit() + @increment)
    return (
      notes: @notes()
      nextPath: (if hasMore then nextPath else null)
    )
)

Router.map ->
  # Sets route for Index to '/' for the application
  @route "index",
    path: "/"
  

  # User Routes
  @route "register",
    path: "/register"

  @route "login",
    path: "/login"

  @route "editUser",
    path: "/profile/edit"
  
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

  # The route to this template is only for testing purposes 
  # The template should be moved to the navbar
  @route "allThreads",
    path: "/threads/"
  
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