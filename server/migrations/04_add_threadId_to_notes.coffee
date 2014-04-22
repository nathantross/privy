Migrations.add
  name: 'Adding a threadId and avatar to each note.'
  version: 4

  up: ->
    Threads.find().forEach (thread) ->
      userId = thread.participants[0].userId
      avatar =  Meteor.users.findOne(userId).profile['avatar']
      Notes.update thread.noteId,
        $set:
          threadId: thread._id
          userAvatar: avatar

  down: ->
    Notes.update {},
      $unset:
          threadId: ""
          userAvatar: ""