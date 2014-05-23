Template.messageIndicators.helpers
  lastMsg: ->
    lastMessage = 
      Messages.findOne
          threadId: @threadId
        ,
          sort:
              createdAt: -1 
    
    if lastMessage
      userIsSender = Meteor.userId() == lastMessage.senderId
      readStatus = timeSince(lastMessage.updatedAt)
      readStatus = readStatus + " ago" if readStatus

      if userIsSender
        if readStatus    
          readStatus = if lastMessage.isRead then "Read #{readStatus}" else "Sent #{readStatus}"
        else
          readStatus = if lastMessage.isRead then "Just read" else "Just sent"

      else
        if readStatus
          readStatus = "Read #{readStatus}"
        else
          readStatus = "Just received"

      return(
        userIsSender: userIsSender
        readStatus: readStatus
      )


  isTyping: ->
    participant = typist(@threadId)
    $('body').scrollTop($("#messages")[0].scrollHeight) if participant && participant.isTyping
    if participant then participant.isTyping else false

  avatar: ->
    Notify.getUserStatus(typist(@threadId).userId, true, false)


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


  typist = (threadId) ->
    thread = Threads.findOne(threadId)
    if thread
      for participant, i in thread.participants
        unless participant.userId == Meteor.userId()
          return participant