Template.showThread.rendered = ->
    Meteor.setTimeout( 
      -> 
        $('body').scrollTop($("#messages")[0].scrollHeight)
      , 200
    )