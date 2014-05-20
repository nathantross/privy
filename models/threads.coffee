exports = this
exports.Threads = new Meteor.Collection('threads')

Meteor.methods
  createThread: ->
      user = Meteor.user()
      
      unless user
        throw new Meteor.Error(401, "You have to login to create a thread.")   

      # whitelisted keys
      now = new Date().getTime()
      thread = 
        participants: [{
          userId: user._id 
          avatar: user.profile['avatar'] 
          }]
        createdAt: now
        updatedAt: now

      Threads.insert(thread) 


  toggleIsTyping: (threadAttr) ->
    threadId = threadAttr.threadId
    user = Meteor.user()
    index = threadAttr.userIndex
    thread = Threads.findOne(threadId)

    unless threadId
        throw new Meteor.Error(404, "This threadId doesn't exist.")

    unless user
        throw new Meteor.Error(401, "Please login to type on this thread.")

    unless threadAttr.toggle == true || threadAttr.toggle == false
        throw new Meteor.Error(400, "Toggle must be set to true or false.")

    unless thread.participants[index].userId == user._id
      throw new Meteor.Error(401, "You cannot change this attribute for someone else.")
 
    modifier = $set: {}
    modifier.$set["participants." + index + ".isTyping"] = threadAttr.toggle
    Threads.update(threadId, modifier)


  toggleIsInThread: (threadAttr)->       
    threadId = threadAttr.threadId
    thread = Threads.findOne(threadId)
    user = Meteor.user()
    index = threadAttr.userIndex
    toggleMuted = threadAttr.isMuted
    toggleCheckIn = threadAttr.toggle

    unless threadId
      throw new Meteor.Error(404, "This threadId doesn't exist.")

    unless toggleCheckIn == true || toggleCheckIn == false
      throw new Meteor.Error(400, "Toggle must be set to true or false.")
    
    unless user
      throw new Meteor.Error(401, "Please login to check into this thread.")

    unless thread
      throw new Meteor.Error(404, "This thread doesn't exist.")

    unless thread.participants[index].userId == user._id
      throw new Meteor.Error(401, "You cannot change this attribute for someone else.")

    if toggleMuted? && toggleMuted != true && toggleMuted != false 
      throw new Meteor.Error(400, "Toggle muted must be set to true or false.")
 
    modifier = $set: {}
    modifier.$set["participants." + index + ".isInThread"] = toggleCheckIn
    if toggleCheckIn == false
      modifier.$set["participants." + index + ".isTyping"] = false 
    if toggleMuted == true || toggleMuted == false
      modifier.$set["participants." + index + ".isMuted"] = toggleMuted
    
    Threads.update threadId, modifier, (err)->
      throw new Meteor.Error(404, "This thread could not be updated.") if err 

    # Add the user to the thread
    now = new Date().getTime()
    if toggleCheckIn == true
      Meteor.users.update(
          _id: user._id
        ,
          $addToSet:
            inThreads: threadId
      )
    else if toggleCheckIn == false
      Meteor.users.update(
          user._id
        ,
          $pull: 
            inThreads: threadId
      )
