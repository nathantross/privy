delay = 1000
Meteor.setTimeout(
  -> 
    Migrations.migrateTo('latest') 
  , delay
)