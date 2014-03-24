exports = this
exports.Notes = new Meteor.Collection('notes')

Notes.allow
  insert: (body, userId, isInstream) ->
    return !! userId