Meteor.publish "threads", ->
  Threads.find #add 'or' query with creator/responder

Meteor.publish "noteActions", (noteId) ->
  NoteActions.find noteId: noteId

Meteor.publish "messages", (threadId) ->
  Messages.find threadId: threadId

Meteor.publish "notes", (options) ->
  Notes.find isInstream: true, options

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