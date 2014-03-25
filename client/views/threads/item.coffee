Template.threadItem.helpers(
  contact: ->
    if Meteor.userId() == @creatorId
      Meteor.users.findOne(_id: @responderId)
    else
      Meteor.users.findOne(_id: @creatorId)
  
  hello: "hi"

  lastMessage: ->
    m = Messages.find(
      threadId: "egXCNvBv35skjqphw"
    ,
      sort:
        createdAt: -1
      limit: 1
    ).fetch()[0]
)