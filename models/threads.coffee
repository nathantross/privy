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
      creatorId: user._id 
      createdAt: now
      updatedAt: now
    )

    Threads.insert(thread)

  updateResponder: (threadId) ->
    user = Meteor.user()
    
    if !user
      throw new Meteor.Error(401, "You have to login to respond to a thread.")

    # whitelisted keys
    now = new Date().getTime()

    Threads.update(threadId, 
      $set:
        responderId: user._id
        updatedAt: now
    )