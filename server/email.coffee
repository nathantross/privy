# in server code
Meteor.Mandrill.sendTemplate
    key: "ZxfQsYGXFG35CBCpSarEKQ"
    # template key
    templateSlug: "test1"
    # template dynamic content
    # example below for when template contains 
    # <div mc:edit="userFirstName"> ("content" value inserted here) </div>
    templateContent: [
        {
          name: "userFirstName"
          content: "Vince Carter"
        }
      ]
    fromEmail: "hello@privy.cc"
    toEmail: "nathantross@gmail.com"

