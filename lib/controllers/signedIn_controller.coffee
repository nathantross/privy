exports = this
exports.signedInController = FeedController.extend(

  onAfterAction: ->
    document.title = Notify.defaultTitle() if Meteor.user()

    # if !Session.get('isTrackingChanges') && Meteor.user()
    #   Notify.trackChanges()
    #   document.title = Notify.defaultTitle() 
    #   Session.set('isTrackingChanges', true)
      
)