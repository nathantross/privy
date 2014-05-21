delay = 1000
Meteor.setTimeout(
  -> 
    Migrations.migrateTo('latest') 
    # Migrations.migrateTo(8) 
  , delay
)