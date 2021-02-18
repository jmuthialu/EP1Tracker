#  EP1 Tracker

Tracks EP1s on a map and provides functionality to lock or unlock an EP if the user is authenticated. The app needs credentials to login. 

(Test credential setup: jay@gm.com; password: jay)

## High Level Architecture

**API Server**

This runs on Node.js and Express framework. User Authentication is performed usng JTW and bcrypt for this exercise. Currently data in the servers lives on memory.  

For real application I would have considered the following:
- User authentication based on OAUTH2 or Okta
- Persist API sever data in mongo db.

**iOS APP**

The underlying architecture uses MVVM to ensure clean separation of components. As much as possible the architecture follows SOLID principles and the class sizes are generally small, which reflect better seperation of concerns. Combine framework is used to bind data models to UI elements. 

The app has four modules supported by service layer and utlities.
- Fleet Module: Trackes fleet of EP1s
- User Module: Authentiocation of users
- Network Module: Network services layer
- Settings Module: Credential management like logoff

**UML Class Diagram**

[Fleet Module](UMLDiagram/FleetModule.jpg)

[User Module](UMLDiagram/UserModule.jpg)

**Note on UI**

The UI design for this app is primarily optimized for dark mode but works in any mode. It follows Auto layout so that it can work as an Universal app but for this assigment iPad is disabled as design is not optimized for iPad.
