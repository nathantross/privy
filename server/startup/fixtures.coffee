# Meteor.startup ->
#   if Meteor.users.find().count() == 0 && window.location.host == "localhost:3000"
#     userIds = []

#     # Create three users
#     users = []

#     users.push( 
#       email: "s@g.com" 
#       password: "tested"
#       profile: 
#         name: "Stu"
#         avatar: "//images.all-free-download.com/images/graphicmedium/studiofibonacci_cartoon_grasshopper_clip_art_22257.jpg"
#         isNotified: false  
#     )

#     users.push(
#       email: "n@g.com" 
#       password: "tested"
#       profile: 
#         name: "Nathan"
#         avatar: "//rs1124.pbsrc.com/albums/l571/cocobiikan/ist2_8825822-panda-cartoon.jpg~c200"
#         isNotified: false  
#     )

#     users.push(
#       email: "z@g.com" 
#       password: "Welcome123"
#       profile: 
#         name: "John"
#         avatar: "//rs560.pbsrc.com/albums/ss48/burneggroll/SMILEYS/Coffee%20and%20Food/chef_hat_cartoon_01P018.jpg~c200"
#         isNotified: false 
#     )

#     users.push(
#       email: "j@g.com" 
#       password: "tested"
#       profile: 
#         name: "Jason"
#         avatar: "//cdn.instructables.com/F7V/Y56V/GTB9PF1L/F7VY56VGTB9PF1L.SQUARE.jpg"
#         isNotified: false 
#     )

#     users.push(
#       email: "a@g.com" 
#       password: "tested"
#       profile: 
#         name: "Alex"
#         avatar: "//cdn.instructables.com/F7V/Y56V/GTB9PF1L/F7VY56VGTB9PF1L.SQUARE.jpg"
#         isNotified: false 
#     )

#     users.push(
#       email: "b@g.com" 
#       password: "tested"
#       profile: 
#         name: "Bob"
#         avatar: "//cdn.instructables.com/F7V/Y56V/GTB9PF1L/F7VY56VGTB9PF1L.SQUARE.jpg"
#         isNotified: false 
#     )


#     for user in users
#       userIds.push(Accounts.createUser(user))

#     Meteor.users.update userIds[3],
#       $set:
#         flags:
#           count: 6
#           isSuspended: true
    
#     # Create notes
#     noteIds = []
#     now
#     # for userId in userIds
#     #   for i in [1...3]
#     for i in [1...30]
#       now = new Date().getTime()
#       noteIds.push(
#         Notes.insert
#           # userId: userId
#           userId: userIds[4]
#           # body: "Hi " + i + " from " + userId
#           body: "Hi " + i
#           isInstream: true
#           createdAt: now
#           updatedAt: now
#           expiresAt: (now + 7*24*60*60*1000) # 7 days from now (in ms)
#       )

#     # Create noteActions
#     # exports = this
#     # exports.NoteActions = new Meteor.Collection('noteActions')
#     # for userId, i in userIds
#     #   now = new Date().getTime()
#     #   NoteActions.insert
#     #     noteId: noteIds[i]
#     #     receiverId: userId
#     #     isSkipped: true
#     #     createdAt: now
#     #     updatedAt: now
    
#     # Create threads
#     threadIds = []
#     for noteId, i in noteIds
#       now = new Date().getTime()
#       threadIds.push(
#         Threads.insert
#           noteId: noteId
#           creatorId: Notes.findOne(noteId).userId 
#           createdAt: now
#           updatedAt: now
#       )
#       Messages.insert
#         threadId: threadIds[i]
#         body: Notes.findOne(noteId).body
#         senderId: Notes.findOne(noteId).userId
#         isRead: false
#         createdAt: now
#         updatedAt: now      
    
#     # Stu responds to Nathan
#     # responses = [3]
#     # for response in responses
#     #   Notes.update noteIds[response], 
#     #     $set:
#     #       isInstream: false
#     #       updatedAt: now
    
#     #   Threads.update threadIds[response], 
#     #     $set:
#     #       responderId: userIds[0]
#     #       updatedAt: now

#     #   # Stu answers
#     #   stuId = userIds[0]
#     #   nathanId = userIds[1]
#     #   stuMsg = "hi back from " + stuId
#     #   nathanMsg = "thanks, hello from " + nathanId 

#     #   # Stu creates message
#     #   now = new Date().getTime()
#     #   Messages.insert
#     #     threadId: threadIds[response]
#     #     body: stuMsg
#     #     senderId: stuId
#     #     isRead: true
#     #     createdAt: now
#     #     updatedAt: now

#     #   #Nathan gets a notifcation
#     #   now = new Date().getTime()
#     #   Notifications.insert
#     #     userId: nathanId
#     #     threadId: threadIds[response]
#     #     lastMessage: stuMsg
#     #     lastAvatar: Meteor.users.findOne(stuId).profile['avatar']
#     #     isNotified: false
#     #     createdAt: now
#     #     updatedAt: now

#     #   # Nathan creates a response
#     #   now = new Date().getTime()
#     #   Messages.insert
#     #     threadId: threadIds[response]
#     #     body: nathanMsg
#     #     senderId: nathanId
#     #     isRead: true
#     #     createdAt: now
#     #     updatedAt: now

#     #   #Stu gets a notifcation
#     #   now = new Date().getTime()
#     #   Notifications.insert
#     #     userId: stuId
#     #     threadId: threadIds[response]
#     #     lastMessage: nathanMsg
#     #     lastAvatar: Meteor.users.findOne(nathanId).profile['avatar']
#     #     isNotified: true
#     #     createdAt: now
#     #     updatedAt: now
      

