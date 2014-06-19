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
    @unblock()
    unless typeof threadAttr.toggle == "boolean"
      throw new Meteor.Error(400, "Toggle must be set to true or false.")

    unless Threads.findOne(threadAttr.threadId)?.participants[threadAttr.userIndex].userId == @userId
      throw new Meteor.Error(401, "You cannot change this attribute for someone else.")
 
    modifier = $set: {}
    modifier.$set["participants." + threadAttr.userIndex + ".isTyping"] = threadAttr.toggle
    Threads.update threadAttr.threadId, modifier


  toggleIsInThread: (threadAttr)->       
    index = threadAttr.userIndex

    unless typeof threadAttr.toggle == "boolean"
      throw new Meteor.Error(400, "Toggle must be set to true or false.")

    unless Threads.findOne(threadAttr.threadId)?.participants[index]?.userId == @userId
      throw new Meteor.Error(401, "You cannot change this attribute for someone else.")

    if threadAttr.isMuted? && typeof threadAttr.isMuted != "boolean"
      throw new Meteor.Error(400, "Toggle muted must be set to true or false.")
 
    modifier = $set: {}
    modifier.$set["participants." + index + ".isInThread"] = threadAttr.toggle
    
    if threadAttr.toggle == false
      modifier.$set["participants." + index + ".isTyping"] = false 
    
    if threadAttr.isMuted?
      modifier.$set["participants." + index + ".isMuted"] = threadAttr.isMuted
    
    Threads.update threadAttr.threadId, modifier, (err)->
      throw new Meteor.Error(404, "This thread could not be updated.") if err 

    # Add the user to the thread
    now = new Date().getTime()
    if threadAttr.toggle
      Meteor.users.update @userId,
        $addToSet:
          inThreads: threadAttr.threadId
    else
      Meteor.users.update @userId,
        $pull: 
          inThreads: threadAttr.threadId
