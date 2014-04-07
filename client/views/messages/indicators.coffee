Template.messageIndicators.helpers
  readStatus: ->
    lastMessage = Messages.findOne
        threadId: @threadId
      ,
        sort:
            updatedAt: -1

    unless lastMessage.senderId == Meteor.userId()
      ""
    else if lastMessage.isRead
      "Read " + messageDate(lastMessage)
    else
      "Sent" 

  messageDate = (message) ->
    d = new Date(0)
    d.setUTCMilliseconds(message.updatedAt)
    d = d.toDateString()

    now = new Date()
    return "today" if now.toDateString() == d
    yesterday = new Date()
    yesterday.setDate(now.getDate() - 1)
    return "yesterday" if yesterday.toDateString() == d
    dateArr = d.split(" ")
    dateArr[2] = dateArr[2].slice(1) if dateArr[2].slice(0, 1) == "0"
    return dateArr[1] + " " + dateArr[2]
    