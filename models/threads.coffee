exports = this
exports.Threads = new Meteor.Collection('threads')

Meteor.methods
  createThread: (threadAttributes) ->
    user = Meteor.user()
    
    if !user
      throw new Meteor.Error(401, "You have to login to create a thread.")

    # whitelisted keys
    now = new Date().getTime()
    thread = _.extend(_.pick(threadAttributes, 'noteId'),
      participants: [{
        userId: user._id 
        avatar: user.profile['avatar'] 
        }]
      createdAt: now
      updatedAt: now
    )

    Threads.insert(thread)

  addParticipant: (noteId) ->
    if Meteor.isServer
      threadId = Threads.findOne(noteId: noteId)._id
      user = Meteor.user()
      
      if !user
        throw new Meteor.Error(401, "You have to login to respond to a thread.")
        
      now = new Date().getTime()

      Threads.update threadId, 
        $set:
          updatedAt: now
        $addToSet:
          participants: 
            {
              userId: user._id
              avatar: user.profile['avatar']
            }

  startTyping: (threadId)->
    index = userIndex(threadId)
    modifier = $set: {}
    modifier.$set["participants." + index + ".isTyping"] = true
    Threads.update(threadId, modifier);

  endTyping: (threadId)->
    index = userIndex(threadId)
    modifier = $set: {}
    modifier.$set["participants." + index + ".isTyping"] = false
    Threads.update(threadId, modifier);

  userIndex = (threadId) ->
    thread = Threads.findOne(threadId)
    for participant, i in thread.participants
      if participant.userId == Meteor.userId()
        return i