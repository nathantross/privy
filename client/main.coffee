# Allows server to set available db objects
Meteor.subscribe('notes')

Meteor.subscribe('threads')

Meteor.subscribe('noteActions')

Meteor.subscribe('messages')


#if Meteor.isClient
  # Meteor.startup ->
  #   mixpanel.init "8fae59e0f1928d0b271b70446613466f"
  #   mixpanel.track "Application Startup", {}
  #   return