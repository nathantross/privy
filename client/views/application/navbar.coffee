Template.navbar.events
  'click #threads-link': (event)->
    Notify.toggleNavHighlight(Meteor.user(), false)
    Meteor.defer ->
        $('#threads-link').addClass('open')

Template.navbar.helpers
  isNavNotified: ->
    user = Meteor.user()
    user.notifications[0].isNavNotified