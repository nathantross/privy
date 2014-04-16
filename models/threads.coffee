exports = this
exports.Threads = new Meteor.Collection('threads')

Meteor.methods
  createThread: (threadAttributes) ->
    user = Meteor.user()
    
    unless user
      throw new Meteor.Error(401, "You have to login to create a thread.")

    unless Notes.findOne(threadAttributes.noteId)
      throw new Meteor.Error(404, "This thread does not have a note.")      

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
      
      unless user
        throw new Meteor.Error(401, "You have to login to respond to a thread.")

      unless threadId
        throw new Meteor.Error(404, "This thread doesn't exist.")

      if thread.participants.length > 2
        throw new Meteor.Error(401, "This thread is full.")

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


  toggleIsTyping: (threadAttr) ->
    threadId = threadAttr.threadId
    user = Meteor.user()
    index = threadAttr.userIndex
    thread = Threads.findOne(threadId)

    unless threadId
        throw new Meteor.Error(404, "This threadId doesn't exist.")

    unless user
        throw new Meteor.Error(401, "Please login to type on this thread.")

    unless Notify.isInThread(user._id, threadId) 
        throw new Meteor.Error(401, "You cannot perform this action on this thread.")

    unless threadAttr.toggle == true || threadAttr.toggle == false
        throw new Meteor.Error(400, "Toggle must be set to true or false.")

    unless thread.participants[index].userId == user._id
      throw new Meteor.Error(401, "You cannot change this attribute for someone else.")
 
    modifier = $set: {}
    modifier.$set["participants." + index + ".isTyping"] = threadAttr.toggle
    Threads.update(threadId, modifier)


  toggleIsInThread: (threadAttr)->       
    threadId = threadAttr.threadId
    index = threadAttr.userIndex
    user = Meteor.user()

    unless threadId
        throw new Meteor.Error(404, "This threadId doesn't exist.")

    unless threadAttr.toggle == true || threadAttr.toggle == false
        throw new Meteor.Error(400, "Toggle must be set to true or false.")
  
    unless user
      throw new Meteor.Error(401, "Please login to check into this thread.")

    thread = Threads.findOne(threadId)
    unless thread
      throw new Meteor.Error(404, "This thread doesn't exist.")

    unless thread.participants[index].userId == user._id
      throw new Meteor.Error(401, "You cannot change this attribute for someone else.")
 
    modifier = $set: {}
    modifier.$set["participants." + index + ".isInThread"] = threadAttr.toggle
    if threadAttr.toggle == false
      modifier.$set["participants." + index + ".isTyping"] = false 
    
    Threads.update(threadId, modifier)