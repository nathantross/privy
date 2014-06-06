Template.emptyFeed.events
  'click #createNote': ->
    mixpanel.track("Empty feed: clicked 'create'")

# Template.emptyFeed.rendered = ->
#   mixpanel.track('emptyFeed: rendered') if Meteor.user()