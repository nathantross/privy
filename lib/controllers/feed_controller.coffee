exports = this
exports.FeedController = RouteController.extend(
  template: "feed"
  
  sort: -> 
    createdAt: -1

  limit: -> 5

  onBeforeAction: ->
    document.title = Notify.defaultTitle()

  waitOn: ->
    Meteor.subscribe "notes", @sort(), @limit()

  onStop: -> 
    Notify.toggleLock(Session.get('currentNoteId'), false)
    Session.set('currentNoteId', false)

  note: ->
    user = Meteor.user()

    note = 
      Notes.findOne
          $and: [
            userId:
              $ne: Meteor.userId()
          , userId:
              $nin: user.blockerIds || []
          , userId:
              $nin: user.blockedIds || []
          ]
          isInstream: true
          $or: [
            currentViewer: Meteor.userId()
          ,
            currentViewer:
              $exists: false
          ]
          skipperIds:
            $ne: Meteor.userId()
          flaggerIds:
            $ne: Meteor.userId()
          replierIds:
            $ne: Meteor.userId()
          $or: [
              flagCount:
                $lt: 2
            , flagCount:
                $exists: false
          ]
    
    if note && !Meteor.user().status.idle
      Session.set('currentNoteId', note._id)
      Notify.toggleLock note._id, true

    return note

  userAttr: ->
    Notify.getUserStatus(@note().userId) if @note()?.userId

  data: ->
    return(
      note: @note()
      userAttr: @userAttr()
    )
)