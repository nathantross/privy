Template.editUser.helpers
  isChecked: ->
    if Meteor.user().notifications[0].sound then "checked" else ""

Template.editUser.events
  
  'click #myonoffswitch': (e) ->
    isChecked = $('input[name=onoffswitch]').prop('checked')
    
    Meteor.call 'toggleSound', isChecked, (err) ->
      console.log err if err

    onOff = if isChecked then "on" else "off"
    Notify.popup('#successAlert', "Your sound is #{onOff}!")
    mixpanel.track 'Sound: #{onOff}'
