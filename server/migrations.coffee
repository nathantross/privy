Migrations.add(
  name: 'Threads have participants instead of creators and responders.'
  version: 1

  up: ->
    threads = Threads.find
      participants: 
        $exists: false

    threads.forEach (thread) ->
      creator = Meteor.users.findOne(thread.creatorId)
      responder = Meteor.users.findOne(thread.responderId)

      if responder
        Threads.update thread._id, 
            $addToSet: 
              participants:
                $each: [
                    userId: creator._id
                    avatar: creator.profile['avatar']
                  , 
                    userId: responder._id
                    avatar: responder.profile['avatar']
                ]
            $unset:
              creatorId: true
              responderId: true
          , 
            multi: true
      else
        Threads.update thread._id, 
            $addToSet: 
              participants:
                $each: [
                  userId: creator._id
                  avatar: creator.profile['avatar']
                ]
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
              creatorId: thread.participants[0].userId
              responderId: thread.participants[1].userId
            $unset: 
              participants: true
          , 
            multi: true 
      else
        Threads.update thread._id, 
            $set:
              creatorId: thread.participants[0].userId
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