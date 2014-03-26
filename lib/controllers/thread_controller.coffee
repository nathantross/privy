# exports = this
# exports.ThreadsController = RouteController.extend(
#   template: "allThreads"
#   limit: 20

#   findOptions: ->
#     sort:
#       updatedAt: -1
#     limit: @limit()

#   query: ->
#     return {$or: [  
#               {creatorId: Meteor.userId()}
#             , 
#               {responderId: Meteor.userId()}
#             ]}

#   waitOn: ->
#     Meteor.subscribe "threads", @query(), @findOptions()

#   threads: ->
#     Threads.find
#         $or: [  
#             creatorId: Meteor.userId()
#           , 
#             responderId: Meteor.userId()
#           ]
#       , 
#         sort: 
#           updatedAt: -1 , 
#         limit: 15
#     # Threads.find @query(), @findOptions()

#   data: ->
#     return ( threads: @threads() )
# )