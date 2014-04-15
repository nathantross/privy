exports = this
exports.signedInController = FeedController.extend(

  onRun: ->
      Notify.trackChanges()
      # document.title = Notify.defaultTitle(Meteor.user())
      
)