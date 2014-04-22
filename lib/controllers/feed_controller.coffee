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

  note: ->
    Notes.findOne
        isInstream: true
        skipperIds:
          $ne: Meteor.userId()
      , 
        sort: @sort()

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