Template.allThreads.helpers
  threads: ->
    Threads.find
        $or: [  
            creatorId: Meteor.userId()
          , 
            responderId: Meteor.userId()
          ]
      , 
        sort: 
          updatedAt: -1 , 
        limit: 15