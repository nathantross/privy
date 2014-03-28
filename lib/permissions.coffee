exports = this
exports.ownsThread = (thread, userId) ->
  thread && (thread.creatorId == userId || thread.responderId == userId)
  