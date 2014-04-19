Template.showThread.rendered = ->
  $('body').scrollTop($("#messagesDiv")[0].scrollHeight)
  if $("#messagesDiv")[0]
    Messages.find(
     threadId: @threadId
    ).observe(
      added: (document)->
        $('body').scrollTop($("#messagesDiv")[0].scrollHeight)
    )