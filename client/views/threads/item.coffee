Template.threadItem.helpers(
  contact: ->
    if Meteor.userId() == @creatorId
      Meteor.users.findOne(_id: @responderId)
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