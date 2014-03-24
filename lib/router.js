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

  this.route('notes', { path: '/notes'
  });

  this.route('notesId', { path: '/notes/:_id'
  });      

  this.route('notesEdit', { path: '/notes/:_id/edit'
  });  

  this.route('notesDestroy', { path: '/notes/:_id/destroy'
  });  

  this.route('usersEdit', { path: '/users/:_id/edit'
  });  

  this.route('threadsId', { path: '/threads/:_id'
  });  

  this.route('privacyPolicy', { path: '/privacy-policy'
  });  

  this.route('termsConditions', { path: '/terms-conditions'
  });  

  this.route('faqs', { path: '/faqs'
  });  

});

