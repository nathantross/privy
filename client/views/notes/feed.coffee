Template.feed.events
  "click #skip": (e, template) ->
    if Meteor.user().notifications[0].firstSkip?   
      Meteor.call 'skipNote', @note._id, @userAttr.isIdle, (error, id) -> 
        console.log(error.reason) if error
    else
      Meteor.call 'toggleFirstSkip', {}, (err) ->
        console.log err if err
      $('#first-skip-alert').slideDown "slow"

  "click #startChat": ->
    $("[name=reply-body]").focus()
    mixpanel.track("Reply: clicked", {
      noteId: @note._id, 
      body: @note.body, 
      creatorId: @note.userId, 
      threadId: @note.threadId, 
      creatorIsOnline: if !@userAttr.isIdle then "Yes" else "No"
    })

  "click #flag": (e)->
    e.preventDefault()
    $('#flagAlert').slideDown "slow"
    mixpanel.track("Flag: clicked", {
      noteId: @note._id, 
      body: @note.body, 
      creatorId: @note.userId, 
      creatorIsOnline: if !@userAttr.isIdle then "Yes" else "No"
    })

Template.feed.helpers
  isUserActive: ->
    "Online" if @userAttr? && !@userAttr.isIdle 
    
  location: ->
    if @note.place
      region = 
        if usStates[@note.place.region]?
          usStates[@note.place.region]
        else
          toTitleCase(@note.place.country)

      city = toTitleCase(@note.place.city)

      unless city == "-" || region == "-"
        "#{city}, #{region}"
      else
        false
    else 
      false

  usStates = 
    'ALABAMA': 'AL'
    'ALASKA': 'AK'
    'AMERICAN SAMOA': 'AS'
    'ARIZONA': 'AZ'
    'ARKANSAS': 'AR'
    'CALIFORNIA': 'CA'
    'COLORADO': 'CO'
    'CONNECTICUT': 'CT'
    'DELAWARE': 'DE'
    'DISTRICT OF COLUMBIA': 'DC'
    'FEDERATED STATES OF MICRONESIA': 'FM'
    'FLORIDA': 'FL'
    'GEORGIA': 'GA'
    'GUAM': 'GU'
    'HAWAII': 'HI'
    'IDAHO': 'ID'
    'ILLINOIS': 'IL'
    'INDIANA': 'IN'
    'IOWA': 'IA'
    'KANSAS': 'KS'
    'KENTUCKY': 'KY'
    'LOUISIANA': 'LA'
    'MAINE': 'ME'
    'MARSHALL ISLANDS': 'MH'
    'MARYLAND': 'MD'
    'MASSACHUSETTS': 'MA'
    'MICHIGAN': 'MI'
    'MINNESOTA': 'MN'
    'MISSISSIPPI': 'MS'
    'MISSOURI': 'MO'
    'MONTANA': 'MT'
    'NEBRASKA': 'NE'
    'NEVADA': 'NV'
    'NEW HAMPSHIRE': 'NH'
    'NEW JERSEY': 'NJ'
    'NEW MEXICO': 'NM'
    'NEW YORK': 'NY'
    'NORTH CAROLINA': 'NC'
    'NORTH DAKOTA': 'ND'
    'NORTHERN MARIANA ISLANDS': 'MP'
    'OHIO': 'OH'
    'OKLAHOMA': 'OK'
    'OREGON': 'OR'
    'PALAU': 'PW'
    'PENNSYLVANIA': 'PA'
    'PUERTO RICO': 'PR'
    'RHODE ISLAND': 'RI'
    'SOUTH CAROLINA': 'SC'
    'SOUTH DAKOTA': 'SD'
    'TENNESSEE': 'TN'
    'TEXAS': 'TX'
    'UTAH': 'UT'
    'VERMONT': 'VT'
    'VIRGIN ISLANDS': 'VI'
    'VIRGINIA': 'VA'
    'WASHINGTON': 'WA'
    'WEST VIRGINIA': 'WV'
    'WISCONSIN': 'WI'
    'WYOMING': 'WY'

  toTitleCase = (str)->
    str.replace /\w\S*/g, (txt) ->
      txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()   
>>>>>>> 0c6fd29f5156932eee5a966dd993fc9ead916807
