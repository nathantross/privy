exports = this
exports.FeedController = RouteController.extend(
  template: "feed"
  # increment: 1
  # notesCount: ->
    # parseInt(@params.notesCount) || @increment

  onBeforeAction: ->
    document.title = Notify.defaultTitle()

  sort: -> 
    createdAt: 1

  limit: ->
    Math.floor(Math.random() * 10) + 20

  waitOn: ->
    Meteor.subscribe "notes", @sort, @limit()

  onStop: -> 
    Notify.toggleLock(Session.get('currentNoteId'), false)
    Session.set('currentNoteId', false)

  note: ->
    note = 
      Notes.findOne
          isInstream: true
          $or: [
            currentViewer: Meteor.userId()
          ,
            currentViewer:
              $exists: false
          ]
          skipperIds:
            $ne: Meteor.userId()
        , 
          sort: @sort()

    if note && !Meteor.user().status.idle
      Session.set('currentNoteId', note._id)
      Notify.toggleLock note._id, true
    
    return note

  data: ->
    return(
      note: @note()
      # nextPath: @route.path(notesCount: @notesCount() + @increment)
    )
    # hasMore = @notes().fetch().length is @limit()
    
    # return (
    #   isPassing: true
    #   notes: @notes()
    #   nextPath: (if hasMore then nextPath else null)
    # )
)