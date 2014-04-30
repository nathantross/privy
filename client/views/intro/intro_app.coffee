Template.intro.events
  'click img': ->
    avatarAttr = @.toString()
    Meteor.call 'setAvatar', avatarAttr, (error) ->
      return console.log (error.reason) if error 


Template.intro.avatars = ["/avatar_1.png","/avatar_2.png","/avatar_3.png","/avatar_4.png"]


Template.intro1.events
  'click #declineTour': -> 
    mixpanel.track("Tour(1): declined")

  'click #startTour': -> 
    mixpanel.track("Tour(1): started")

Template.intro2.events
  'click .intro-finish': ->
    mixpanel.track("Tour(2): exited")

  'click .intro-next': ->
    mixpanel.track("Tour(2): continued")

Template.intro3.events
  'click .intro-finish': ->
    mixpanel.track("Tour(3): exited")

  'click .intro-next': ->
    mixpanel.track("Tour(3): continued")

Template.intro4.events
  'click .intro-finish': ->
    mixpanel.track("Tour(4): exited")

  'click .intro-next': ->
    mixpanel.track("Tour(4): continued")

Template.intro5.events
  'click #getStarted': ->
    mixpanel.track("Tour(5): completed")