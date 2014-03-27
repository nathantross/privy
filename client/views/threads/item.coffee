Template.threadItem.helpers(
  contact: ->
    if Meteor.userId() == @creatorId
      if @responderId
        Meteor.users.findOne(_id: @responderId)
      else
        Meteor.user()
    else
      Meteor.users.findOne(_id: @creatorId)

  lastMessage: ->
    Messages.find(
      threadId: @_id
    ,
      sort:
        createdAt: -1
      limit: 1
    ).fetch()[0]
)
