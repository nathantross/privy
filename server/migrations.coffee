Migrations.add(
  name: 'Threads have participants instead of creators and responders.'
  version: 1

  up: ->
    threads = Threads.find
      participants: 
        $exists: false

    threads.forEach (thread) ->
      creator = thread.creatorId || ""
      responder = thread.responderId || ""

      Threads.update thread._id, 
          $addToSet: 
            participants:
              $each: [creator, responder]
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
      creator = participants[0] || ""
      responder = participants[1] || ""
      Threads.update {}, 
          $set:
            creatorId: creator
            responderId: responder 
          $unset: 
            participants: true
        , 
          multi: true 
)

# Migrations.migrateTo('latest')