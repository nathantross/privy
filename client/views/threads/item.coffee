Template.threadItem.helpers
  avatar: ->
    contact
    if Meteor.userId() == @creatorId
      if @responderId
        contact = Meteor.users.findOne(_id: @responderId)
      else
        contact = Meteor.user()
    else
      contact = Meteor.users.findOne(_id: @creatorId)

    if contact then contact.profile.avatar else ""

  lastMessage: ->
    message = Messages.find(
      threadId: @_id
    ,
      sort:
        createdAt: -1
      limit: 1
    ).fetch()[0]

    # Return the substring of the message
    if message 
      message = message.body
      previewLength = 20 # change this to update number of characters
      if previewLength < message.length
        message = message.slice(0, previewLength) + "..."
    else
      message = ""

    message

  notify: ->
    n = 
      Notifications.findOne
        userId: Meteor.userId()
        threadId: @_id        
    if n then n.isNotified else false
     

Template.threadItem.events
  'click a': ->
    n = Notifications.findOne
      userId: Meteor.userId() 
      threadId: @_id

    if n && n.isNotified
      Notifications.update n._id,
        $set:
          isNotified: false