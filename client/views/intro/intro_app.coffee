Template.intro.events
  'click img': ->
    avatarAttr = @.toString()
    Meteor.call 'setAvatar', avatarAttr, (error) ->
      return console.log (error.reason) if error 


Template.intro.avatars = ["https://s3-us-west-2.amazonaws.com/privy-application/avatar_1.png","https://s3-us-west-2.amazonaws.com/privy-application/avatar_2.png","https://s3-us-west-2.amazonaws.com/privy-application/avatar_3.png","https://s3-us-west-2.amazonaws.com/privy-application/avatar_4.png", "https://s3-us-west-2.amazonaws.com/privy-application/avatar_5.png", "https://s3-us-west-2.amazonaws.com/privy-application/avatar_6.png",]


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
    Notify.popup('#successAlert', "You're ready. Now, chat away!")

Template.intro5.events
  'click #getStarted': ->
    mixpanel.track("Tour(5): completed")