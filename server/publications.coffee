Meteor.publish "threads", ->
  Threads.find()

Meteor.publish "noteActions", ->
  NoteActions.find()

Meteor.publish "messages", ->
  Messages.find()

Meteor.publish "notes", (options) ->
  Notes.find {}, options

# Example limiting db shared
# Meteor.publish "notes", ->
#   Posts.find flagged: false

# Notifications
# Meteor.publish "notifications", ->
#   Notifications.find userId: @userId


# A more secure pattern could be passing 
# the individual parameters themselves instead of 
# the whole object, to make sure you stay in control 
# of your data:
# Meteor.publish('posts', function(sort, limit) {
#   return Posts.find({}, {sort: sort, limit: limit});
# });