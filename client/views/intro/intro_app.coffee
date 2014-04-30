Template.intro.events
  'click img': ->
    avatarAttr = @.toString()
    Meteor.call 'setAvatar', avatarAttr, (error) ->
      return console.log (error.reason) if error 


Template.intro.avatars = ["/avatar_1.png","/avatar_2.png","/avatar_3.png","/avatar_4.png"]

Template.intro.rendered = ->
  Notify.popup("#successAlert", "Welcome to Privy! Let's take a tour.", true)

Template.intro1.events
  'click .intro-finish': ->
    mixpanel.track("Tour(1): exited")

  'click .intro-next': ->
    mixpanel.track("Tour(1): continued")
    

Template.intro2.events
  'click .intro-finish': ->
    mixpanel.track("Tour(2): exited")

  'click .intro-next': ->
    mixpanel.track("Tour(2): continued")


Template.intro3.events
  'click .intro-next': ->
    mixpanel.track("Tour(3): completed")