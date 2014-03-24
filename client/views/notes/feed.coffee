Template.feed.helpers 
  notes: ->
    Notes.find(
        isInstream: true
      ,
        sort:
          updatedAt: -1
    )