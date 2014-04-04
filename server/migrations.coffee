Migrations.add(
  name: 'Threads have participants instead of creators and responders.'
  version: 1

  up: ->
    threads = Threads.find
      participants: 
        $exists: false

    threads.forEach (thread) ->
      creator = thread.creatorId
      responder = thread.responderId 

      if responder
        Threads.update thread._id, 
            $addToSet: 
              participants:
                $each: [creator, responder]
            $unset:
              creatorId: true
              responderId: true
          , 
            multi: true
      else
        Threads.update thread._id, 
            $addToSet: 
              participants:
                $each: [creator]
            $unset:
              creatorId: true
              responderId: true
          , 
            multi: true
  down: ->
    threads = Threads.find
      participants: 
        $exists: true

    threads.forEach (thread) ->
      # Note: down sets first two participants as creator and responder
      # any subsequent participants will be lost
      unless thread.participants[1]
        Threads.update thread._id, 
            $set:
              creatorId: participants[0]
              responderId: participants[1]
            $unset: 
              participants: true
          , 
            multi: true 
      else
        Threads.update thread._id, 
            $set:
              creatorId: participants[0]
            $unset: 
              participants: true
          , 
            multi: true 
)

delay = 1000
Meteor.setTimeout(
  -> 
    Migrations.migrateTo('latest') 
  , delay
)