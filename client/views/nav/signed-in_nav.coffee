Template.signedInNav.helpers
  isIntro: ->
    disabledPaths = ['intro', 'intro_1', 'intro_2', 'intro_3']
    currentPath = Router.current().path.split('/')[1]
    
    _.indexOf(disabledPaths, currentPath) != -1


Template.signedInNav.events
  'click #addNote': ->
    mixpanel.track("Nav: clicked add note")

