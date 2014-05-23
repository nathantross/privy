Template.signedInNav.events
  'click #dropdown-li': (event)->
    Notify.toggleNavHighlight(false)
    Notify.toggleTitleFlashing(false)

  'click #sign-out': ->
    mixpanel.track("User: signed out")

  'click #noteFeed': ->
    mixpanel.track("Nav: clicked note feed")

  'click #settings': ->
    mixpanel.track("Nav: clicked settings")

  'click #logo': ->
    mixpanel.track("Nav: clicked logo")

  'click #addNote': ->
    mixpanel.track("Nav: clicked add note")

Template.signedInNav.helpers
  isNavNotified: ->
    user = Meteor.user().notifications
    if user && user[0].isNavNotified then "nav-notify" else ""

  isIntro: ->
    disabledPaths = ['intro', 'intro_1', 'intro_2', 'intro_3']
    currentPath = Router.current().path.split('/')[1]

    _.indexOf(disabledPaths, currentPath) == 1