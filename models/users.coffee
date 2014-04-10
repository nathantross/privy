Meteor.methods
  toggleNavHighlight: (userAttr) ->
    userId = userAttr._id
    now = new Date().getTime()
    userUpdate = _.extend(_.pick(userAttr, 'notifications.0.isNavNotified'),
      updatedAt: now
    )
    Meteor.users.update(
        userId
      ,
        $set: userUpdate
    )

  toggleTitleFlashing: (userAttr) ->
    userId = userAttr._id
    now = new Date().getTime()
    userUpdate = _.extend(_.pick(userAttr, 'notifications.0.isTitleFlashing'),
      updatedAt: now
    )
    Meteor.users.update(
        userId
      ,
        $set: userUpdate
    )

  changeCount: (userAttr) ->
    userId = userAttr._id
    now = new Date().getTime()
    userUpdate = _.pick(userAttr, 'notifications.0.count')
    
    Meteor.users.update(userId,
      $set: 
        updatedAt: now
      $inc: userUpdate
    )