exports = this
exports.Notify = 
  changeCount: (user, inc) ->
    userAttr = 
      _id: user._id
      'notifications.0.count': inc
    Meteor.call('changeCount', userAttr, (error, id)->
      alert(error.reason) if error
    )

  playSound: (user, filename) ->
    if user.notifications[0].sound
      document.getElementById("sound").innerHTML = "<audio autoplay=\"autoplay\"><source src=\"" + filename + ".mp3\" type=\"audio/mpeg\" /><source src=\"" + filename + ".ogg\" type=\"audio/ogg\" /><embed hidden=\"true\" autostart=\"true\" loop=\"false\" src=\"" + filename + ".mp3\" /></audio><!-- \"Waterdrop\" by Porphyr (freesound.org/people/Porphyr) / CC BY 3.0 (creativecommons.org/licenses/by/3.0) -->"

  toggleNavHighlight: (user, toggle)->
    unless user.notifications[0].isNavNotified == toggle
      userAttr = 
        _id: user._id
        'notifications.0.isNavNotified': toggle
      Meteor.call('toggleNavHighlight', userAttr, (error, id)->
        alert(error.reason) if error
      )

  toggleItemHighlight: (notification, toggle) ->
    unless notification.isNotified == toggle
      notAttr = 
        _id: notification._id
        isNotified: toggle
      Meteor.call('toggleItemHighlight', notAttr, (error, id)->
        alert(error.reason) if error
      )

  toggleTitleFlashing: (user, toggle) ->
    unless user.notifications[0].isTitleFlashing == toggle
      userAttr =
        _id: user._id
        'notifications.0.isTitleFlashing': toggle
      Meteor.call('toggleTitleFlashing', userAttr, (error, id)->
        alert(error.reason) if error
      )

    if toggle
      Meteor.clearInterval(Session.get('intervalId'))
      intervalId = @flashTitle(user)
      Session.set('intervalId', intervalId)

  flashTitle: (user)->
    if user.notifications[0].isTitleFlashing
      notCount = user.notifications[0].count
      title = 
        if notCount > 0 then "Privy (" + notCount + " unread)" else "Privy"
      
      Meteor.setInterval( () -> 
          newTitle = "New private message..."
          document.title = 
            if document.title == newTitle then title else newTitle
        , 3000)

  popup: ->
    $("#popup").slideDown "slow", ->
      Meteor.setTimeout(()-> 
          $("#popup").slideUp("slow")
        , 3000)