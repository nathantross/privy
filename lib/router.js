// Provide the router with the name of a loading template
Router.configure({
layoutTemplate: 'layout',

// waitOn lets us load 'feed' in the background
// until it loads fully. Giving loading template beforehand
// loadingTemplate: 'loading',
// waitOn: function() { return Meteor.subscribe('feed'); }
});

// Sets route for Index to '/' for the application
Router.map(function() { this.route('index', {path: '/'});

  this.route('register', { path: '/register'
  });

  this.route('login', { path: '/login'
  });

  this.route('register', { path: '/register'
  });

  this.route('feed', { path: '/feed'
  });      

  this.route('message', { path: '/message'
  });  

  // this.route('exampleroute', { path: '/user/:_id'
  // });  



});

