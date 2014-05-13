Template.emptyFeed.events
  'click #createNote': ->
    mixpanel.track("Empty feed: clicked 'create'")

Template.emptyFeed.rendered = ->
  console.log "empty"  