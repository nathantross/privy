# Provide the router with the name of a loading template
Router.configure 
  layoutTemplate: "layout"
  yieldTemplates:
    'navbar':
      to: 'navRegion'
  loadingTemplate: "loading"
  notFoundTemplate: 'notFound'

  onRun: ->
    mixpanel.disable() if window.location.host == "localhost:3000"

exports = this
exports.Subs = new SubsManager()


Router.map ->
  # Sets route for Index to '/' for the application
  @route "index",
    path: "/"
    onBeforeAction: ->
      document.title = "Strange"
      Session.set("isTrackingChanges", false)
      Router.go "feed" if Meteor.user()


  # User Routes    
  @route "editUser",
    path: "/profile/edit"

  @route "termsUrl",
    path: "/terms-of-use"

  @route "privacyUrl",
    path: "/privacy-policy"

  @route "contact",
    path: "/contact" 

  @route "intro",
    path: "/intro"

  @route "intro1",
    path: "/intro_1"

  @route "intro2",
    path: "/intro_2"

  @route "intro3",
    path: "/intro_3"


  # Note Routes
  @route "newNote",
    path: "/notes/new"
    onRun: ->
      mixpanel.track('Note: visited newNote')

  @route "feed",
    path: "/notes" 
    controller: FeedController

  @route "showNote",
    path: "/notes/:_id"
    controller: showNoteController
    

  # Thread Route
  @route "showThread",
    path: "/threads/:_id/:msgLimit?"
    controller: showThreadController

  @route "faq",
    path: "/faq"


loginChecks = (pause)->
  if Meteor.user() 
    if Meteor.user().flags?.isSuspended
      @render "suspended" 
      pause()
    if !Meteor.user().profile?.avatar || Meteor.user().profile.avatar == null
      @render if Meteor.loggingIn() then @loadingTemplate else "intro"
      pause()
  else
    @render( if Meteor.loggingIn() then @loadingTemplate else "entrySignIn" )
    pause()

loggedOutPages = ["index", "register", "termsUrl", "privacyUrl", "entrySignUp", "entrySignIn", "entryResetPassword", "contact", "entryForgotPassword", "404", "showNote"]

Router.waitOn ->
    Subs.subscribe 'userData'
    Subs.subscribe 'chatsData'
  ,
    except: loggedOutPages

Router.onBeforeAction loginChecks,
  except: loggedOutPages
