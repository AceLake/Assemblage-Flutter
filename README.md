# Assemblage

- [About the Project](https://github.com/AceLake/Assemblage-Flutter#about-the-project)
- [Project Requirements](https://github.com/AceLake/Assemblage-Flutter#project-requirements)
- [Logical System Design](https://github.com/AceLake/Assemblage-Flutter#logical-system-design)
- [Physical Solution Design](https://github.com/AceLake/Assemblage-Flutter#physical-solution-design)
- [Detailed Technical Design](https://github.com/AceLake/Assemblage-Flutter#detailed-technical-design)
- [Widget Layout Design](https://github.com/AceLake/Assemblage-Flutter#widget-layout-design)

# About the Project

## ABSTRACT

What Is Assemblage? The whole basis for the app is in Matthew 18:20 where we are called to assemble to rejoice in the presence of God. Assemblage is a platform used to bring people together to study God's word, not only to understand Him further but to strengthen our relationship with him while at the same time strengthening our relationship with the body of Christ. Everyone should be able to easily find and join a Bible study group. 

Assemblage is a Bible study group management software where a user can create or join a Bible study group where they can be in touch with others in the group. Different features make it easy to find a group as well as stay in touch with the group. One of these features is a group messaging system which allows essay communication between group members to keep everyone on the same page. It will also have a feature that will use Google Maps to find Bible study near you. Not all groups need to be publicly visible. Only groups that want to be seen can be seen and the groups who want to stay private can stay private and the group location won't be shown. Events will also be shown on the home page so if you want to go above and beyond you can help spread the love of God.

Why did I want to make this app? I found out that joining a Bible study group was a lot harder and daunting than I thought you would either have to go through a church or know people who are in a group already. This seemed way more difficult than it should be. Getting to know God and the body of Christ should be easy and Assemblage will make it easy.

## Project Overview and Project Objectives

### Problem and Background

From personal experience joining a Bible study group is way harder than it should be. My experience in finding a Bible study group was 100% God's doing. In the 2nd semester of my freshman year of college, I had no friends on campus I was alone I never went to church because I was too nervous to socialize with hundreds of people, but I still wanted to study the word with others. Around this time, I met up with only 2 other guys as a study group for a math class. One of them owned a motorcycle and drove it often. One night he invited me to a Bible study group 10 minutes in advance and I said yes. It turns out that some random guy put a sticky note on my friend's bike asking him to join which made him ask me to join last minute. So long story short it was a lot harder than it should be to join a Bible study group.

# Project Requirements

## Functional and Non-Functional Requirements
- [This is the link to the requirements spreadsheet](https://docs.google.com/spreadsheets/d/12-eE0rKsRIRkCST4E56qvA3O3NXUvT5u/edit?usp=sharing&ouid=116486810360149009769&rtpof=true&sd=true)

## Challenges
### All new technologies
- Having everything new to me made it really difficult from the beginning because even documenting the technologies was a challenge. I used Firebase which is a No-SQL database and I had to learn how to make an ER diagram equivalent. Also documenting for mobile development was difficult too. I had to document as if Dart wasn't an OOP language where I had to make component designs as well as detailed UMLs.
- Styling mobile apps was foreign to me where instead of using HTML for styling I had to learn an entirely new front-end styling language. Flutter uses widgets to style the pages which was hard to make exactly what I wanted the app to look like. 

## Risks
### Real-time messaging
- I watched a video that went over how to create a messaging app with Dart and I used that as a POC for managing this risk.

## Issues 
- The main issue I had wasn't coding the application it was mainly setting up the development environment. I had to install all of the SDKs and had to install emulators for both IOS and Android. Some days both Android and IOS would be working but that next morning my SDK would be out of date and would have to update all of these little technologies. My Android app stopped working for like a month and so I started only developing on IOS then I tried Android once again and worked, but I still don't know why. Sometimes it wouldn't work then I would close VS Code and re-open it and it works so it's fidgety.

### Hardware and Software Technologies
Here are all of the technologies used within the development of the application along with their versions so that if someone is brought onto the development team they will know what they need to help in development.


- Microsoft Windows Version 10.0.19045.3693
- Android Studio Version  2022.3
- Android SDK version 34.0.0
- Google Pixel 3 34GB (simulator)
- MacOS 13.5
- Xcode 15.0
- iPhone 15 (simulator)
- iPhone 8+ (physical)
- Flutter Version 3.13.2
- Firebase
- Visual Studio Community Version 2022 17.3.6
- VS Code Version 1.84.2

### Why Flutter, Dart, and Firebase?
First off I chose these technologies because they were all new to me and I wanted to learn mobile development. Puting on my developer hat, Dart is the main programming language that I wanted to use for my app and Flutter is an amazing framework for it.
I chose Firebase as my database mainly because of its compatibility with Flutter apps and the fact that they are Google technologies which means they will have a lot of support and documentation to learn from.

## Logical System Design
<img width="339" align="center " alt="image" src="https://github.com/AceLake/Assemblage-Flutter/assets/96988100/24fd4451-47bf-4360-8da4-79cce762c462">


### Description

#### Logical System Design
Assemblage will be logically organized into four different logical layers. The first layer is the presentation layer, followed by the business layer, the data access layer, and finally, the database.

#### Presentation Layer
The presentation layer contains all the code that is used to be presented to the user. This includes various widgets and pages that the user can interact with. This code forms the graphical user interface (GUI).

#### Business Logic Layer
The business logic layer houses the services responsible for managing the background processes of the application. This layer serves as a middleman that utilizes the CRUD (Create, Read, Update, Delete) methods stored within the Data Access Layer.

#### Data Access Layer
The data access layer establishes connections to the database and incorporates methods responsible for querying the data to and from the database. It acts as an intermediary between the business logic layer and the database, facilitating seamless communication and data retrieval.

#### Database
The database serves as the repository for all information essential for the application's operations. It stores the data required for executing various functionalities within the system.

## Physical Solution Design

<img width="734" alt="image" src="https://github.com/AceLake/Assemblage-Flutter/assets/96988100/e9422bfe-7091-4182-b059-7360ffc8db3d">


### Description

#### Physical Solution Design
The Physical Solution Design provides a representation of the actual physical development environment for the app. The code is created using Visual Studio Code (VS Code) on the host device. This setup ensures a robust testing and development environment, allowing for efficient cross-platform development and thorough testing on both simulated and physical devices.

#### Android testing
Currently, Android testing is conducted on a Windows PC, utilizing the Android Studio for running the Android simulator. VS Code seamlessly detects the running simulator and facilitates deployment onto the simulated Android environment.

#### IOS testing
Similarly, iOS testing is performed on a MacBook, employing the iPhone simulator through Xcode. VS Code efficiently recognizes the simulated iOS device, enabling deployment during the development process.

#### Physical testing
For wired connections, Xcode builds the application and deploys it onto a physically connected iPhone, streamlining the testing process on real iOS devices.

## Detailed Technical Design
This section will hold all of the diagrams to help the development team understand what is needed to develop the application to industry standards. This is conveyed through the use of diagrams and descriptions surrounding the given diagrams to help with interpretation.
 
### General Technical Approach
The structure of Assemblage should be built for adaptability for different types of data as well as an overall structure to create a multi-platform experience. Also, assemblage should be built with ease of use in mind. The application should be set up to store massive amounts of data

### Key Technical Design Decisions:
Assemblage will use the Flutter framework with Dart as its primary programming language. The database is Firebase which is a Non-relational database. 

The reason why I wanted to use Flutter for the framework for my application was to support cross-platform to give more users the ability to find and use the app. Flutter's main hook is that it allows for the app to be used with a variety of different platforms.

Dart was chosen for its object-oriented nature which allows the app to be more scalable.

Firebase was chosen because of its NoSQL structure. Having NoSQL within the app will allow it to be able to store massive amounts of data while also being adaptable to store different types of data.

### Document Structure Diagram 
<img width="595" alt="image" src="https://github.com/AceLake/Assemblage-Flutter/assets/96988100/8b76ca12-4b43-43bc-9cce-2596910c8034">

Here is how each document relates to each other in my Firebase database. Firebase is a NoSQL Database so they are not documented the same but I used a UML class diagram to create a NoSQL Entity Relational diagram. Each User holds a list of Groups they are a part of and also has a list of messages they have sent as a list of message objects. Each group has a list of message objects that represent all of the messages in that group.



## Sitemap
![Assemblage Site Map drawio (1)](https://github.com/AceLake/Assemblage-Flutter/assets/96988100/6cc9b906-e596-4f17-ac66-e2fa8cd68c99)

### Description

- Green: all of the create operations in the application.
- Purple: all of the read operations in the application.
- Orange: all of the update operations in the application.
- Red: all of the delete operations in the application.
- Blue: all of the non-CRUD features. Usually, it’s a static page or an action not connected to the database.

When the application is initially launched, users will be seamlessly directed to the login page. If they are new to the platform, they can easily navigate to the registration page directly from the login page. Once users successfully log in or complete the registration process, they will be immediately redirected to the home page.

Throughout the application, excluding the login and registration pages, users have 5 common pages they can navigate to. At the bottom of the screen, a navigational bar provides access to 4 core pages of the app, ensuring easy and convenient navigation from any point within the application. Additionally, an app bar positioned at the top of the page allows users to access their profile information effortlessly.

## Widget layout design
### Description 
Purple: Stateless Widget 
<br>
Red: List Widget 
<br>
Green: List Item Widget
<br>

<details>
  <summary>App Bar Widget</summary>
  <p>
   
![image](https://github.com/AceLake/Assemblage-Flutter/assets/96988100/5a49d9e3-d49f-4060-9c27-954cf515ccfd)
- This is the default App bar view but it has many states 
- Pulls out a drawer that logs the user out
- Pulls out a drawer that navigates to the details page or leaves the group.
  </p>
</details>
<details>
  <summary>NavBar</summary>
  <p>
   
![image](https://github.com/AceLake/Assemblage-Flutter/assets/96988100/449ead43-3670-4eed-b100-f005b2471f06)

- Holds Page navigation to different pages in the app. Each Icon is clickable.
- Home Page navigation as the first icon to the left
- Find Group navigation as the second icon to the left
- Group Creation navigation as the 3rd icon to the left
- Chats as the last icon furthest to the right
- Each item in the nav bar displays the name when clicked on, so the search tab isn't the only one like that
  </p>
</details>
<details>
  <summary>Login</summary>
  <p>
   
   #### GIF

   ![Loggingin-ezgif com-video-to-gif-converter](https://github.com/AceLake/Assemblage-Flutter/assets/96988100/3f2af8b3-9b08-49db-a1f5-62f72c8da03a)
   
   #### Component Design
   
   ![image](https://github.com/AceLake/Assemblage-Flutter/assets/96988100/32c97ef9-9e15-455d-8b46-b5ab97d5e452)


#### Login Body
- This widget is a stateless widget 
- It acts as an entire page for logging in a user
#### Username Input Text Feild
- This widget uses a text input widget that will take in text from the user
- For this specific widget, it will take in the text that will be compared to a username field in the user document in Firebase
#### PasswordInput Text Feild
- This widget uses an input widget that will take in text from the user
- For this specific widget, it will take in the text that will be compared to a username field in the user's document in Firebase
#### Submit Button
- This is a button widget
- This button initializes the login and checks if the user with that username and password exists.
#### Go to Register
- This is a link widget
- It will route the user to the registration page if clicked
  </p>
</details>

<details>
  <summary>Registration</summary>
  <p>
   
   #### GIF
   
  ![Registration-ezgif com-video-to-gif-converter](https://github.com/AceLake/Assemblage-Flutter/assets/96988100/76ff12cd-65d4-4754-8336-f625f271767e)
  
  #### Component Design
   ![image](https://github.com/AceLake/Assemblage-Flutter/assets/96988100/1d2c17bc-2fd8-4b96-b470-dc730b5fb10d)

#### Registration body
- This is a stateless widget
- It holds all of the widgets needed for registering a user
#### Username Input
- Text input widget
- The username entered will check if that is usable
- If it isn't usable it will not allow the user to use that username
- It will add a user with the given username when submitted
#### Password input
- Text input widget
- The password entered will check if that is usable
- If it isn't usable it will not allow the user to use that password 
- It will add a user with the given password when submitted
#### Confirm Password Input
- Text input widget
- Checks if the given password matches the initial given password
#### Register Button
- This is a button widget
- This button initializes the registration and adds the user to the user's list
#### Go to Login HyperLink
- This is a link widget
- It will route the user to the login page if clicked
</p>
</details>

<details>
  <summary>Home</summary>
  <p>
   
  #### GIF
   
  ![Loggingout-ezgif com-video-to-gif-converter](https://github.com/AceLake/Assemblage-Flutter/assets/96988100/bd91a73e-78ce-4812-b886-c923d8b472be)

  #### Component Design
  ![image](https://github.com/AceLake/Assemblage-Flutter/assets/96988100/693cd8f8-8755-475c-a625-2135a24f0079)
 

  #### App Bar
  - The description is given in the App Bar section
  - This App bar pulls out a drawer that allows the user to logout

  #### Nav Bar
  - The description is given in the Nav Bar section
  </p>
</details>

<details>
  <summary>Find a group</summary>
  <p>
   
  #### GIF
   
  ![JoiningLeaving-ezgif com-video-to-gif-converter](https://github.com/AceLake/Assemblage-Flutter/assets/96988100/bdd0df00-3a95-4ebb-a124-03bad47300e0)

  #### Component Design
  ![image](https://github.com/AceLake/Assemblage-Flutter/assets/96988100/faf3f75c-1254-46ef-b65e-abb6facd54dd)

#### App Bar
- The description given in the App Bar section
#### Group Search Body
- Stateless widget
- Holds all of the widgets that are needed on the Find a Group page
#### Search Text Input 
- Text input widget
- The text entered will search if the group name or location matches the text given
#### List of Groups
- List Widget
- Contains a list of groups that have visibility to the public
#### Group Box 
- Item Widget
- Each group box contains important info
- Group Name
- Group Location
- Only City and state
- Meeting time
- Then the concept or book the group is currently studying
- When the see more link is clicked then it will navigate to the specific group info
#### Nav Bar
- The description given in the Nav Bar section

  
  </p>
</details>

<details>
  <summary>Group Creation</summary>
  <p>
   
  #### GIF
   
  ![GroupCreation-ezgif com-video-to-gif-converter](https://github.com/AceLake/Assemblage-Flutter/assets/96988100/4af1f759-9462-4901-a917-728921425748)

  #### Component Design
  ![image](https://github.com/AceLake/Assemblage-Flutter/assets/96988100/b901216b-488b-4c95-848d-2363c7ff5a13)

#### App Bar
- The description is given in the App Bar section
#### Create Group Body
- Stateless Widget
- contains all of the widgets that are needed in the Create Group Page 
#### Group Name Input
- Text Input Widget
- The name given in the input relates to the group name in the database
- on submission, this name will be set for the group
#### About Group Input
- Text Input Widget
- The text given in the input relates to the group’s About section in the database
- on submission, this About section will be set for group
#### Group Info Input
- Text Input Widgets
- allows the user to input text for each section
- Location
- Meeting time
- Concept or book the group is currently studying
#### Set Group Public/Private
- Check Box Widget
- When checked sets the group to public
#### Create Group Button
- Button Widget
- On click creates the group
#### Nav Bar
- The description given in the Nav Bar section

  
  </p>
</details>

<details>
  <summary>Group Details</summary>
  <p>

  #### Component Design
  
  ![image](https://github.com/AceLake/Assemblage-Flutter/assets/96988100/b2c14379-3f8a-4f85-b55a-e9a41980eaac)

#### App Bar
- The description given in the App Bar section
#### Group Details Body
- This is a stateless widget
- It contains all of the widgets that are needed
#### Join Button
- Button Widget
- Once the button is clicked it will send a request to join
#### Group Details
- This displays more info about the group
- Group Name
- About the Group
- Location
- Meeting time
- Then the concept or book the group is currently studying
#### Group Members List
- List Widget
- Contains every member of the group
#### Group Member
- List Item Widget
- Contains info about the user
- Name
#### Nav Bar
- The description is given in the Nav Bar section

  
  </p>
</details>

<details>
  <summary>My Groups</summary>
  <p>
   
  #### GIF
  ![Mygroups-ezgif com-video-to-gif-converter](https://github.com/AceLake/Assemblage-Flutter/assets/96988100/b621cadf-87ff-4da9-ac9a-f75e114aee3d)

  #### Component Design
  ![image](https://github.com/AceLake/Assemblage-Flutter/assets/96988100/fc699328-0938-44d6-9826-d996ae9db46f)

#### App Bar
- The description is given in the App Bar section
#### My Groups Body
- Stateless Widget
- contains all of the widgets that are needed in Your Groups
#### My Group List
- List Widget
- Lists off all of the groups the current user is a part of
#### My Group List Item
- List Item Widget
- Displays the last message sent as well as the group name
- On click it navigates to the messaging for that specific group
#### Nav Bar
- The description is given in the Nav Bar section


  </p>
</details>

<details>
  <summary>Chat Page</summary>
  <p>

  #### GIF
  
  ![Real-Time Messaging GIF](https://github.com/AceLake/Assemblage-Flutter/assets/96988100/7b275b29-c144-4e4e-aaed-90322da00a3d)
  
  #### Component Design
  
  ![Chat Page Component Design](https://github.com/AceLake/Assemblage-Flutter/assets/96988100/00891cb7-c5ff-42e3-ac5d-6e75babced6d)

#### App Bar
- Description given in the App Bar section
#### Group Messages Body
- Stateless Widget
- contains all of the widgets that are needed in Create Group Page 
#### Group Settings 
- Link Widget
- On click navigate to the edit group page
#### List of Group Messages
- List Widget
- This is where all of the group messages are displayed for all users in the group to see. The current user sees their messages apart from the other members in the group.
#### Your Sent Messages
- List Item Widget
- These are the messages sent by the current user of the app.
- If the message is held down allow the user to edit or delete the message
#### Other group members' messages
- List Item Widget
- These are the messages sent by the other members in the group excluding the current user.
#### Messaging Text Input
- Text Input Widget
- When the text in this input is sent it adds a new message to the group.

  
  </p>
</details>









