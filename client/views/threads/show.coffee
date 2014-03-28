Template.showThread.helpers
  messages: ->
    Messages.find
      threadId: @_id
    ,
      sort:
          updatedAt: 1

  