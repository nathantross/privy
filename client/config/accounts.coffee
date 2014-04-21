Meteor.startup ->
  AccountsEntry.config
    privacyUrl: '/privacy-policy'
    termsUrl: '/terms-of-use'
    homeRoute: 'index'
    dashboardRoute: 'feed'
    IntroRoute: 'intro'
    profileRoute: 'profile'
    passwordSignupFields: 'EMAIL_ONLY'
    showSignupCode: false
