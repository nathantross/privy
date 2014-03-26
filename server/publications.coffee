Meteor.publish "threads", ->
  Threads.find()

Meteor.publish "NoteActions", (noteId) ->
  NoteActions.find()

Meteor.publish "messages", ->
  Messages.find()

Meteor.publish "notes", (options) ->
  Notes.find isInstream: true, options

Meteor.publish "users", ->
  Meteor.users.find()

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