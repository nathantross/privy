Template.messageIndicators.helpers
  readStatus: ->
    lastMessage = Messages.findOne(
        threadId: @threadId
      ,
        sort:
            updatedAt: -1) 

    unless lastMessage && lastMessage.senderId == Meteor.userId()
      ""
    else if lastMessage && lastMessage.isRead
      "Read " + messageDate(lastMessage)
    else
      "Sent " + messageDate(lastMessage)

  isTyping: ->
    participant = typist(@threadId)
    if participant then participant.isTyping else false

  avatar: ->
    typist(@threadId).avatar

  messageDate = (message) ->
    d = new Date(0)
    d.setUTCMilliseconds(message.updatedAt)
    d = d.toDateString()

    # if the date is today, return "today"
    now = new Date()
    return "today" if now.toDateString() == d
    
    # if the date is yesterday, return 'yesterday'
    yesterday = new Date()
    yesterday.setDate(now.getDate() - 1)
    return "yesterday" if yesterday.toDateString() == d
    
    # if the date is before yesterday, return the date
    dateArr = d.split(" ")
    dateArr[2] = dateArr[2].slice(1) if dateArr[2].slice(0, 1) == "0"
    return dateArr[1] + " " + dateArr[2]
  
  typist = (threadId) ->
    thread = Threads.findOne(threadId)
    if thread
      for participant, i in thread.participants
        unless participant.userId == Meteor.userId()
          return participant