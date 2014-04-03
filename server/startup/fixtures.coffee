Meteor.startup ->
  if Meteor.users.find().count() == 0
    userIds = []

    # Create three users
    userIds.push(
      Accounts.createUser
          email: "stuart.stein@gmail.com" 
          password: "Welcome123"
          profile: 
            name: "Stu"
            avatar: "//images.all-free-download.com/images/graphicmedium/studiofibonacci_cartoon_grasshopper_clip_art_22257.jpg"
            isNotified: false  
    )

    userIds.push(
      Accounts.createUser
          email: "nathantross@gmail" 
          password: "Welcome123"
          profile: 
            name: "Nathan"
            avatar: "//rs1124.pbsrc.com/albums/l571/cocobiikan/ist2_8825822-panda-cartoon.jpg~c200"
            isNotified: false 
    )

    userIds.push(
      Accounts.createUser
          email: "johndoe@gmail" 
          password: "Welcome123"
          profile: 
            name: "John"
            avatar: "//rs560.pbsrc.com/albums/ss48/burneggroll/SMILEYS/Coffee%20and%20Food/chef_hat_cartoon_01P018.jpg~c200"
            isNotified: false 
    )
    
    # Create notes
    noteIds = []
    now = new Date().getTime()
    for userId in userIds
      for i in [1...3]
        now = new Date().getTime()
        noteIds.push(
          Notes.insert
            userId: userId
            body: "Hi from " + userId
            isInstream: true
            createdAt: now
            updatedAt: now
            expiresAt: (now + 7*24*60*60*1000) # 7 days from now (in ms)
        )
    
    # Create threads
    threadIds = []
    for noteId in noteIds
      now = new Date().getTime()
      threadIds.push(
        Threads.insert
          noteId: noteId
          creatorId: Notes.findOne(noteId).userId 
          createdAt: now
          updatedAt: now
      )
    
    # Stu responds to Nathan
    responses = [3]
    for response in responses
      Notes.update noteIds[response], 
        $set:
          isInstream: false
          updatedAt: now
    
      Threads.update threadIds[response], 
        $set:
          responderId: userIds[0]
          updatedAt: now

      # Stu answers
      now = new Date().getTime()
      Messages.insert
        threadId: threadIds[response]
        body: "hi back from " + userIds[0]
        senderId: userIds[0]
        createdAt: now
        updatedAt: now
        isRead: true

      # Nathan responds 
      now = new Date().getTime()
      Messages.insert
        threadId: threadIds[response]
        body: "thanks, hello from " + userIds[1] 
        senderId: userIds[1]
        createdAt: now
        updatedAt: now
        isRead: false

