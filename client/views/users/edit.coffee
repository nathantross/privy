Template.editUser.helpers
  switches: ->
    data = 
      [
          label: "Sound:"
          name: "sound"
          isChecked: if Meteor.user().notifications[0].sound then "checked" else "" 
        ,
          label: "Email:"
          name: "email"
          isChecked: if Meteor.user().notifications[0].email then "checked" else "" 
      ]
    return data

Template.editUser.events
  
  'click #sound-switch': (e) ->
    toggleSwitch("sound")

  'click #email-switch': (e) ->
    toggleSwitch("email")

  'click #sign-out': ->
    mixpanel.track "User: signed out"

  toggleSwitch = (name) ->

    toTitleCase = (str) ->
      str.replace /\w\S*/g, (txt) ->
        txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()

    inputName = 'input[name=' + name + '-switch]'
    isChecked = $(inputName).prop('checked')
    
    Meteor.call 'toggleNotifications', isChecked, name, (err) ->
      console.log err if err

    onOff = if isChecked then "on" else "off"
    Notify.popup('#successAlert', "Your #{name} is #{onOff}!")
    mixpanel.track "#{toTitleCase(name)}: #{onOff}"
