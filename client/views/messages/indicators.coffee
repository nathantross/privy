Template.messageIndicators.helpers
  lastMessage: ->
    Messages.find
      threadId: @_id
    ,
      sort:
          updatedAt: 1
      limit: 1
  
  readStatus: ->
    "Sent"

  readDate: ->
    d = new Date(0)
    d.setUTCSeconds(@lastMessage.updatedAt)

    d = d.toDateString()
    now = new Date()
    return "today" if now.toDateString() == d
    return "yesterday" if now.setDate(now.getDate() - 1).toDateString() == d
    dateArr = d.split(" ")
    return dateArr[1] + " " + dateArr[2]

# Template.messageIndicators.rendered = ->
  # lastMessage = Messages.find
  #     threadId: @_id
  #   ,
  #     sort:
  #         updatedAt: 1
  #     limit: 1
  # unless lastMessage.senderId == Meteor.userId() && lastMessage.isRead
    
  #   msgUpdates = 
  #     isRead: true
  #     messageId: lastMessage._id

  #   Meteor.call('updateRead', msgUpdates, (error, id)->
  #       alert(error.reason) if error # need better error handling
  #       @readDate()
  #       @readStatus = "Read"
  #   )
