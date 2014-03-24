Meteor.startup( () ->
  if Threads.find().count() == 0
    Threads.insert(threadId: 102, noteId: Notes.findOne( {noteId: 1} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "ricster@fast.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "RLSSTONE@sbcglobal.net"} } })._id)
    Threads.insert(threadId: 100, noteId: Notes.findOne( {noteId: 4} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "rhendricks21@comcast.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "hermanwing@msn.com"} } })._id)
    Threads.insert(threadId: 130, noteId: Notes.findOne( {noteId: 7} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "wchandler098@comcast.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "trmhogan@comcast.net"} } })._id)
    Threads.insert(threadId: 95, noteId: Notes.findOne( {noteId: 9} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "PWDEAL@earthlink.NET"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "spwineguy@aol.com"} } })._id)
    Threads.insert(threadId: 85, noteId: Notes.findOne( {noteId: 16} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "nancymc51@aol.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "raymond.garceau@att.net"} } })._id)
    Threads.insert(threadId: 71, noteId: Notes.findOne( {noteId: 18} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "magokay@hotmail.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "jjesse337@aol.com"} } })._id)
    Threads.insert(threadId: 121, noteId: Notes.findOne( {noteId: 19} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "TRHemail@aol.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "jamesw3300@aol.com"} } })._id)
    Threads.insert(threadId: 37, noteId: Notes.findOne( {noteId: 20} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "franks53@suddenlink.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "clintchc@aol.com"} } })._id)
    Threads.insert(threadId: 122, noteId: Notes.findOne( {noteId: 25} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "TRHemail@aol.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "wb0ytj@juno.com"} } })._id)
    Threads.insert(threadId: 116, noteId: Notes.findOne( {noteId: 26} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "stevep@psu.edu"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "hartlej5354@gmail.com"} } })._id)
    Threads.insert(threadId: 13, noteId: Notes.findOne( {noteId: 27} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "Bracymarion@aol.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "dews327@yahoo.com"} } })._id)
    Threads.insert(threadId: 57, noteId: Notes.findOne( {noteId: 29} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "jthibadeau@gmail.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "ssab44@yahoo.com"} } })._id)
    Threads.insert(threadId: 131, noteId: Notes.findOne( {noteId: 31} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "WPRINCE1@AOL.COM"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "elsheridan@gmail.com"} } })._id)
    Threads.insert(threadId: 16, noteId: Notes.findOne( {noteId: 32} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "Cakes1@aol.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "lee73120@aol.com"} } })._id)
    Threads.insert(threadId: 22, noteId: Notes.findOne( {noteId: 36} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "compasslaka@peoplepc.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "csmikm@gmail.com"} } })._id)
    Threads.insert(threadId: 81, noteId: Notes.findOne( {noteId: 39} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "MPaup@prodigy.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "rjwemail@aol.com"} } })._id)
    Threads.insert(threadId: 45, noteId: Notes.findOne( {noteId: 40} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "HWallsJOAN@aol.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "RPSmith116@aol.com"} } })._id)
    Threads.insert(threadId: 86, noteId: Notes.findOne( {noteId: 41} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "nancymc51@aol.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "johnnyi50@aol.com"} } })._id)
    Threads.insert(threadId: 55, noteId: Notes.findOne( {noteId: 42} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "jrk540@q.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "Mrbeard1@aol.com"} } })._id)
    Threads.insert(threadId: 61, noteId: Notes.findOne( {noteId: 44} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "kenwarner@worldnet.att.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "bjhdd710@cox.net"} } })._id)
    Threads.insert(threadId: 32, noteId: Notes.findOne( {noteId: 45} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "edmccabe@midohio.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "lmpcnp@comcast.net"} } })._id)
    Threads.insert(threadId: 53, noteId: Notes.findOne( {noteId: 48} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "jmwallace54@comcast.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "bevdnewsome@yahoo.com"} } })._id)
    Threads.insert(threadId: 33, noteId: Notes.findOne( {noteId: 49} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "ervingaylard@hotmail.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "rondo@adelphia.net"} } })._id)
    Threads.insert(threadId: 76, noteId: Notes.findOne( {noteId: 50} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "MceVoy-M@subway.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "davedavies1961@msn.com"} } })._id)
    Threads.insert(threadId: 66, noteId: Notes.findOne( {noteId: 51} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "lennypessin@yahoo.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "paulshep@ev1.net"} } })._id)
    Threads.insert(threadId: 126, noteId: Notes.findOne( {noteId: 55} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "washburn.arthur3@gmail.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "ravenquille@earthlink.net"} } })._id)
    Threads.insert(threadId: 82, noteId: Notes.findOne( {noteId: 56} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "mprocelli@msn.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "DalePotter@ATT.NET"} } })._id)
    Threads.insert(threadId: 59, noteId: Notes.findOne( {noteId: 57} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "kbaker4640@aol.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "rbh1948@i-55.com"} } })._id)
    Threads.insert(threadId: 58, noteId: Notes.findOne( {noteId: 60} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "jthibadeau@gmail.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "jgeorg@cox.net"} } })._id)
    Threads.insert(threadId: 15, noteId: Notes.findOne( {noteId: 63} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "BUCROSPAR3@AOL.COM"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "jljjslo@klink.net"} } })._id)
    Threads.insert(threadId: 80, noteId: Notes.findOne( {noteId: 65} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "morganjnc@seii.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "SQAWBETTY@AOL.COM"} } })._id)
    Threads.insert(threadId: 84, noteId: Notes.findOne( {noteId: 66} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "mv1313@yahoo.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "bcarmichael1@charter.net"} } })._id)
    Threads.insert(threadId: 5, noteId: Notes.findOne( {noteId: 69} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "apollo18@wedtv.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "neilsdeals231@cs.com"} } })._id)
    Threads.insert(threadId: 87, noteId: Notes.findOne( {noteId: 72} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "neat@ameritech.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "wb0ytj@juno.com"} } })._id)
    Threads.insert(threadId: 51, noteId: Notes.findOne( {noteId: 75} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "jdeigan@erols.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "sgtdsd@hotmail.com"} } })._id)
    Threads.insert(threadId: 11, noteId: Notes.findOne( {noteId: 77} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "Bocoman@aol.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "dickhanley17@cox.net"} } })._id)
    Threads.insert(threadId: 83, noteId: Notes.findOne( {noteId: 80} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "MSMEISLIN@ADELPHIA.NET"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "WAYPER@zoominternet.net"} } })._id)
    Threads.insert(threadId: 89, noteId: Notes.findOne( {noteId: 81} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "nynex01@verizon.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "NUCLEARBT@AOL.COM"} } })._id)
    Threads.insert(threadId: 127, noteId: Notes.findOne( {noteId: 83} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "wb0ytj@juno.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "Krr267mama@aol.com"} } })._id)
    Threads.insert(threadId: 69, noteId: Notes.findOne( {noteId: 89} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "lowdog@twlakes.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "jb710@zoominternet.net"} } })._id)
    Threads.insert(threadId: 14, noteId: Notes.findOne( {noteId: 90} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "Bracymarion@aol.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "bdmcswain@cox.net"} } })._id)
    Threads.insert(threadId: 60, noteId: Notes.findOne( {noteId: 91} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "kebrooks@snet.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "lennypessin@yahoo.com"} } })._id)
    Threads.insert(threadId: 93, noteId: Notes.findOne( {noteId: 94} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "pitts@tampabay.rr.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "frost103710@msn.com"} } })._id)
    Threads.insert(threadId: 56, noteId: Notes.findOne( {noteId: 102} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "JSHowie@mediaone.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "jthibadeau@gmail.com"} } })._id)
    Threads.insert(threadId: 6, noteId: Notes.findOne( {noteId: 111} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "apollo18@wedtv.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "richoverton@verizon.net"} } })._id)
    Threads.insert(threadId: 30, noteId: Notes.findOne( {noteId: 112} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "DTPISSOS@AOL.COM"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "timhwade@knology.net"} } })._id)
    Threads.insert(threadId: 114, noteId: Notes.findOne( {noteId: 114} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "srburr@comcast.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "osure23@optimum.net"} } })._id)
    Threads.insert(threadId: 20, noteId: Notes.findOne( {noteId: 119} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "clarence@tds.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "bdmcswain@cox.net"} } })._id)
    Threads.insert(threadId: 129, noteId: Notes.findOne( {noteId: 120} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "WBRUCEEVANS@BELLSOUTH.NET"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "stevep@psu.edu"} } })._id)
    Threads.insert(threadId: 108, noteId: Notes.findOne( {noteId: 121} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "rvose@netway.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "cwieds@aol.com"} } })._id)
    Threads.insert(threadId: 97, noteId: Notes.findOne( {noteId: 122} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "R_SHILLINGTON@YAHOO.COM"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "RLSSTONE@sbcglobal.net"} } })._id)
    Threads.insert(threadId: 36, noteId: Notes.findOne( {noteId: 124} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "fladevfund@aol.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "sgt.rock@embarqmail.com"} } })._id)
    Threads.insert(threadId: 41, noteId: Notes.findOne( {noteId: 125} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "goodwr3@pa.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "stephan.newhouse@morganstanley.com"} } })._id)
    Threads.insert(threadId: 18, noteId: Notes.findOne( {noteId: 126} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "carlbgrimmett@comcast.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "simpsonjoe@comcast.net"} } })._id)
    Threads.insert(threadId: 34, noteId: Notes.findOne( {noteId: 130} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "ferencsik@msn.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "jhstcktn@cs.com"} } })._id)
    Threads.insert(threadId: 92, noteId: Notes.findOne( {noteId: 133} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "paulshep@ev1.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "bigguy@penn.com"} } })._id)
    Threads.insert(threadId: 72, noteId: Notes.findOne( {noteId: 134} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "mamkrm@att.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "MceVoy-M@subway.com"} } })._id)
    Threads.insert(threadId: 28, noteId: Notes.findOne( {noteId: 136} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "DMVendingRepair@aol.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "jdhoeschen@charter.net"} } })._id)
    Threads.insert(threadId: 2, noteId: Notes.findOne( {noteId: 137} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "64mustang@ameritech.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "vthrall@frontiernet.net"} } })._id)
    Threads.insert(threadId: 39, noteId: Notes.findOne( {noteId: 142} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "garyelwood45@hotmail.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "weedeater710@aol.com"} } })._id)
    Threads.insert(threadId: 23, noteId: Notes.findOne( {noteId: 143} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "davedavies1961@msn.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "richardmckenna@att.net"} } })._id)
    Threads.insert(threadId: 38, noteId: Notes.findOne( {noteId: 144} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "frost103710@msn.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "compasslaka@peoplepc.com"} } })._id)
    Threads.insert(threadId: 106, noteId: Notes.findOne( {noteId: 146} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "rondo@adelphia.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "myrtle710@aol.com"} } })._id)
    Threads.insert(threadId: 63, noteId: Notes.findOne( {noteId: 147} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "KRALS2915@sbcglobal.NET"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "bevdnewsome@yahoo.com"} } })._id)
    Threads.insert(threadId: 19, noteId: Notes.findOne( {noteId: 148} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "chiefsailor@msn.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "djc47@sbcglobal.net"} } })._id)
    Threads.insert(threadId: 124, noteId: Notes.findOne( {noteId: 150} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "volzins@mchsi.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "lfbbfw@ntelos.net"} } })._id)
    Threads.insert(threadId: 7, noteId: Notes.findOne( {noteId: 152} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "asku3@verizon.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "UFFDA81@verizon.net"} } })._id)
    Threads.insert(threadId: 25, noteId: Notes.findOne( {noteId: 153} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "delgearing@wavmax.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "delgearing@wavmax.com"} } })._id)
    Threads.insert(threadId: 67, noteId: Notes.findOne( {noteId: 158} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "Leosroar7@comcast.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "elsheridan@gmail.com"} } })._id)
    Threads.insert(threadId: 113, noteId: Notes.findOne( {noteId: 159} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "sklors@hotmail.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "HWHUCK@AOL.COM"} } })._id)
    Threads.insert(threadId: 103, noteId: Notes.findOne( {noteId: 160} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "rlalphonse@sault.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "dd710@bellsouth.net"} } })._id)
    Threads.insert(threadId: 35, noteId: Notes.findOne( {noteId: 165} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "ferencsik@msn.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "wb0ytj@juno.com"} } })._id)
    Threads.insert(threadId: 101, noteId: Notes.findOne( {noteId: 166} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "rhendricks21@comcast.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "bevdnewsome@yahoo.com"} } })._id)
    Threads.insert(threadId: 128, noteId: Notes.findOne( {noteId: 168} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "wb0ytj@juno.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "Edward.Kubisek@HP.com"} } })._id)
    Threads.insert(threadId: 47, noteId: Notes.findOne( {noteId: 169} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "jameszang555@hotmail.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "margieericksen@gmail.com"} } })._id)
    Threads.insert(threadId: 70, noteId: Notes.findOne( {noteId: 170} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "lowdog@twlakes.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "rhendricks21@comcast.net"} } })._id)
    Threads.insert(threadId: 52, noteId: Notes.findOne( {noteId: 171} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "jdeigan@erols.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "mazzeoo@sbcglobal.net"} } })._id)
    Threads.insert(threadId: 90, noteId: Notes.findOne( {noteId: 173} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "nynex01@verizon.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "HWHUCK@AOL.COM"} } })._id)
    Threads.insert(threadId: 43, noteId: Notes.findOne( {noteId: 175} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "hrmasnik@gmail.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "Mrbeard1@aol.com"} } })._id)
    Threads.insert(threadId: 26, noteId: Notes.findOne( {noteId: 177} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "DiLullo@prodigy.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "lindacrossfield1@gmail.com"} } })._id)
    Threads.insert(threadId: 98, noteId: Notes.findOne( {noteId: 178} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "R_SHILLINGTON@YAHOO.COM"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "rvose@netway.com"} } })._id)
    Threads.insert(threadId: 118, noteId: Notes.findOne( {noteId: 179} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "TKMartin@Unforgettable.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "mikemccaffree@gmail.com"} } })._id)
    Threads.insert(threadId: 111, noteId: Notes.findOne( {noteId: 183} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "sjohns55@tampabay.rr.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "hermanwing@msn.com"} } })._id)
    Threads.insert(threadId: 78, noteId: Notes.findOne( {noteId: 192} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "mdcjeep@aol.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "lenholmberg@msn.com"} } })._id)
    Threads.insert(threadId: 68, noteId: Notes.findOne( {noteId: 193} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "LES710@verizon.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "svferguson@optonline.net"} } })._id)
    Threads.insert(threadId: 46, noteId: Notes.findOne( {noteId: 194} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "hyoung10@comcast.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "swoyerld@verizon.net"} } })._id)
    Threads.insert(threadId: 17, noteId: Notes.findOne( {noteId: 195} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "Cakes1@aol.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "washburn.arthur3@gmail.com"} } })._id)
    Threads.insert(threadId: 24, noteId: Notes.findOne( {noteId: 196} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "dd710@bellsouth.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "ld.naone@verizon.net"} } })._id)
    Threads.insert(threadId: 42, noteId: Notes.findOne( {noteId: 200} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "gzarbano@dcwisp.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "jdaley3018@comcast.net"} } })._id)
    Threads.insert(threadId: 96, noteId: Notes.findOne( {noteId: 201} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "PWDEAL@earthlink.NET"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "33rockyknob@gmail.com"} } })._id)
    Threads.insert(threadId: 94, noteId: Notes.findOne( {noteId: 207} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "pitts@tampabay.rr.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "debrickkinder@aol.com"} } })._id)
    Threads.insert(threadId: 74, noteId: Notes.findOne( {noteId: 209} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "mattingly4447@windstream.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "volzins@mchsi.com"} } })._id)
    Threads.insert(threadId: 125, noteId: Notes.findOne( {noteId: 210} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "vthrall@frontiernet.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "jdeigan@erols.com"} } })._id)
    Threads.insert(threadId: 50, noteId: Notes.findOne( {noteId: 211} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "jdaniel999@aol.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "wsmcfadden@comcast.net"} } })._id)
    Threads.insert(threadId: 31, noteId: Notes.findOne( {noteId: 213} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "edelrick0@verizon.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "HMHAVERS@CS.COM"} } })._id)
    Threads.insert(threadId: 104, noteId: Notes.findOne( {noteId: 214} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "rlirei@peoplepc.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "richoverton@verizon.net"} } })._id)
    Threads.insert(threadId: 12, noteId: Notes.findOne( {noteId: 216} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "Bossadagang2@msn.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "wllkmbll@aol.com"} } })._id)
    Threads.insert(threadId: 1, noteId: Notes.findOne( {noteId: 219} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "33rockyknob@gmail.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "gramanina@aol.com"} } })._id)
    Threads.insert(threadId: 119, noteId: Notes.findOne( {noteId: 220} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "tmanos@concursive.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "philliac@aol.com"} } })._id)
    Threads.insert(threadId: 91, noteId: Notes.findOne( {noteId: 221} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "oharabs@gmail.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "dgenier@insightbb.com"} } })._id)
    Threads.insert(threadId: 109, noteId: Notes.findOne( {noteId: 222} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "rvose@netway.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "Pataska@adelphia.net"} } })._id)
    Threads.insert(threadId: 123, noteId: Notes.findOne( {noteId: 223} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "TRHemail@aol.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "frconsidine@gmail.com"} } })._id)
    Threads.insert(threadId: 112, noteId: Notes.findOne( {noteId: 225} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "SJSYLVESTER1@adelphia.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "james9398@verizon.net"} } })._id)
    Threads.insert(threadId: 77, noteId: Notes.findOne( {noteId: 227} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "MceVoy-M@subway.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "RES330@aol.com"} } })._id)
    Threads.insert(threadId: 99, noteId: Notes.findOne( {noteId: 230} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "rflynn-cv9@juno.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "leroy.cobb@kvnet.org"} } })._id)
    Threads.insert(threadId: 73, noteId: Notes.findOne( {noteId: 231} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "mamkrm@att.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "gcirish@sbcglobal.net"} } })._id)
    Threads.insert(threadId: 27, noteId: Notes.findOne( {noteId: 235} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "djar4@hotmail.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "SPATSESQ@aol.com"} } })._id)
    Threads.insert(threadId: 29, noteId: Notes.findOne( {noteId: 236} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "donbenchoff@comcast.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "RKirsch9649@hotmail.com"} } })._id)
    Threads.insert(threadId: 110, noteId: Notes.findOne( {noteId: 240} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "rvose@netway.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "mazzeoo@sbcglobal.net"} } })._id)
    Threads.insert(threadId: 48, noteId: Notes.findOne( {noteId: 242} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "janneep@mailstation.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "PWDEAL@earthlink.NET"} } })._id)
    Threads.insert(threadId: 117, noteId: Notes.findOne( {noteId: 243} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "tgrip1@sisna.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "raebrevol@yahoo.com"} } })._id)
    Threads.insert(threadId: 62, noteId: Notes.findOne( {noteId: 244} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "kmoh13@msn.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "johnjumper@msn.com"} } })._id)
    Threads.insert(threadId: 4, noteId: Notes.findOne( {noteId: 247} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "APatton@eprod.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "oharabs@gmail.com"} } })._id)
    Threads.insert(threadId: 44, noteId: Notes.findOne( {noteId: 253} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "hubbard333@hotmail.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "neilsdeals231@cs.com"} } })._id)
    Threads.insert(threadId: 75, noteId: Notes.findOne( {noteId: 255} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "maxwell62@verizon.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "swoyerld@verizon.net"} } })._id)
    Threads.insert(threadId: 49, noteId: Notes.findOne( {noteId: 256} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "jc852@aol.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "Rjksteele@aol.com"} } })._id)
    Threads.insert(threadId: 120, noteId: Notes.findOne( {noteId: 257} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "Trailblazer710@aol.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "dgenier@insightbb.com"} } })._id)
    Threads.insert(threadId: 105, noteId: Notes.findOne( {noteId: 258} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "rlstoecker@earthlink.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "GFFAY13@GMAIL.COM"} } })._id)
    Threads.insert(threadId: 8, noteId: Notes.findOne( {noteId: 260} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "Barraccus@aol.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "delgearing@wavmax.com"} } })._id)
    Threads.insert(threadId: 133, noteId: Notes.findOne( {noteId: 264} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "WWWJAW@aol.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "33rockyknob@gmail.com"} } })._id)
    Threads.insert(threadId: 115, noteId: Notes.findOne( {noteId: 267} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "steven.p.rice@worldnet.att.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "GMELT46@AOL.COM"} } })._id)
    Threads.insert(threadId: 54, noteId: Notes.findOne( {noteId: 269} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "joycecoy@aol.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "jcp@mountainmax.net"} } })._id)
    Threads.insert(threadId: 65, noteId: Notes.findOne( {noteId: 270} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "lee73120@aol.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "Rjksteele@aol.com"} } })._id)
    Threads.insert(threadId: 40, noteId: Notes.findOne( {noteId: 285} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "garyelwood45@hotmail.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "jimbob815@juno.com"} } })._id)
    Threads.insert(threadId: 79, noteId: Notes.findOne( {noteId: 286} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "mikemccaffree@gmail.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "c2itnext@yahoo.com"} } })._id)
    Threads.insert(threadId: 64, noteId: Notes.findOne( {noteId: 289} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "ld.naone@verizon.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "KC0FIU@SBCGLOBAL.NET"} } })._id)
    Threads.insert(threadId: 88, noteId: Notes.findOne( {noteId: 290} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "need4speed60@earthlink.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "mazzeoo@sbcglobal.net"} } })._id)
    Threads.insert(threadId: 132, noteId: Notes.findOne( {noteId: 291} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "wrmrgr2@sbcglobal.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "mapmeilak@charter.net"} } })._id)
    Threads.insert(threadId: 21, noteId: Notes.findOne( {noteId: 294} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "clarence@tds.net"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "DMGFLG@AOL.COM"} } })._id)
    Threads.insert(threadId: 9, noteId: Notes.findOne( {noteId: 295} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "bevdnewsome@yahoo.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "rbinhood0063@aol.com"} } })._id)
    Threads.insert(threadId: 107, noteId: Notes.findOne( {noteId: 296} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "RPSmith116@aol.com"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "smith4486@sbcglobal.net"} } })._id)
    Threads.insert(threadId: 3, noteId: Notes.findOne( {noteId: 297} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "AAG@HCI.NET"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "JSHowie@mediaone.net"} } })._id)
    Threads.insert(threadId: 10, noteId: Notes.findOne( {noteId: 300} )._id, creatorId: Meteor.users.findOne({emails: {$elemMatch: {address: "BOARD617@ATT.NET"} } })._id, responderId: Meteor.users.findOne({emails: {$elemMatch: {address: "petersen1928@charter.net"} } })._id)
)



