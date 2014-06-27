Template.notification.helpers
  lastMessagePreview: ->
    textPreview @lastMessage, 22 if @lastMessage

  originalNotePreview: -> 
    textPreview @originalNote, 70 if @originalNote

  notifiedStyle: ->
    if @isNotified then "pull-right fa fa-circle" else ""

  sender: ->
    if @lastAvatarId
      userAttr = Notify.getUserStatus @lastAvatarId

      isOnline = 
        if userAttr.isOnline && @lastAvatarId != Meteor.userId() then "•" else ""

      return(
        avatar: userAttr.avatar
        isOnline: isOnline
      )

    
  lastMsg: ->
    lastMessage = 
      Messages.findOne
          threadId: @threadId
        ,
          sort:
              createdAt: -1 
          reactive: false
    
    if lastMessage
      userIsSender = Meteor.userId() == lastMessage.senderId
      readStatus = timeSince(lastMessage.updatedAt || lastMessage.createdAt)
      readStatus =  if readStatus then readStatus + " ago" else "Just now"
      return readStatus


  textPreview = (message, previewLength) ->
    if previewLength < message.length
      message.slice(0, previewLength) + "..."
    else
      message


  timeSince = (msgDate) ->
    date = new Date(0)
    date.setUTCMilliseconds(msgDate)

    seconds = (new Date() - date) / 1000
    
    interval = seconds / 31536000
    return pluralize(Math.floor(interval), "year")  if interval > 1

    interval = seconds / 2592000
    return pluralize(Math.floor(interval), "month")  if interval > 1
    
    interval = seconds / 86400
    return pluralize(Math.floor(interval), "day") if interval > 1
    
    interval = seconds / 3600
    return pluralize(Math.floor(interval), "hour") if interval > 1
    
    interval = seconds / 60
    return pluralize(Math.floor(interval), "minute") if interval > 1
    
    false
    

  pluralize = (amount, str)->
    answer = 
    if amount == 1 
      aOrAn =
        if str == "hour" then "an" else "a"
      aOrAn + " "  + str
    else
      amount + " " + str + "s"



Template.notification.events
  'click .archive': (e)->
    e.preventDefault()
    Meteor.call "toggleArchived", @_id, true, (err, notId)->
      console.log err if err  
    mixpanel.track "Notification: archived"

  'click .notification-link': ->
    mixpanel.track "Notification: clicked"    
