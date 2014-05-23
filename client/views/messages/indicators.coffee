Template.messageIndicators.helpers
  readStatus: ->
    lastMessage = 
      Messages.findOne
          threadId: @threadId
        ,
          sort:
              createdAt: -1 
          
    unless lastMessage && lastMessage.senderId == Meteor.userId() && !lastMessage.hasExited
      return ""

    else
      timeStr = timeSince(lastMessage.updatedAt)
      
      if timeStr
        timeStr = timeStr + " ago"
        return if lastMessage.isRead then "Read #{timeStr}" else "Sent #{timeStr}"
      
      return if lastMessage.isRead then "Just read" else "Just sent"

  isTyping: ->
    participant = typist(@threadId)
    $('body').scrollTop($("#messages")[0].scrollHeight) if participant && participant.isTyping
    if participant then participant.isTyping else false

  avatar: ->
    typist(@threadId).avatar


  timeSince = (msgDate) ->
    date = new Date(0)
    date.setUTCMilliseconds(msgDate)

    seconds = Math.floor((new Date() - date) / 1000)
    
    interval = Math.floor(seconds / 31536000)
    return pluralize(interval, "year")  if interval > 1

    interval = Math.floor(seconds / 2592000)
    return pluralize(interval, "month")  if interval > 1
    
    interval = Math.floor(seconds / 86400)
    return pluralize(interval, "day") if interval > 1
    
    interval = Math.floor(seconds / 3600)
    return pluralize(interval, "hour") if interval > 1
    
    interval = Math.floor(seconds / 60)
    return pluralize(interval, "minute") if interval > 1
    
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