Meteor.publish "threads", ->
  Threads.find()

Meteor.publish "noteActions", ->
  NoteActions.find()

Meteor.publish "messages", ->
  Messages.find()

Meteor.publish "notes", ->
  Notes.find()


# Example limiting db shared
# Meteor.publish "notes", ->
#   Posts.find flagged: false