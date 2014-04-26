Template.intro.events
  'click img': ->
    avatarAttr = @.toString()
    Meteor.call 'setAvatar', avatarAttr, (error) ->
      return console.log (error.reason) if error 
      console.log "Success: " + Meteor.user().profile.avatar


Template.intro.avatars = ["/avatar_1.png","/avatar_2.png","/avatar_3.png","/avatar_4.png"]