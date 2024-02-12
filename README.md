# Assemblage

- [About the Project](https://github.com/AceLake/Assemblage-Flutter#about-the-project)
- [Project Requirements](https://github.com/AceLake/Assemblage-Flutter#project-requirements)

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

## Technical Requirements

- Flutter
- Dart
- Visual Studio Code
- Firebase
- Android Studio
- Xcode

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
### Login
![image](https://github.com/AceLake/Assemblage-Flutter/assets/96988100/bdb6c372-9d04-43d7-affa-55b49bfecb42)
#### 1. Login Body
- This widget is a stateless widget 
- It acts as an entire page for logging in a user
#### 2. Username Input Text Feild
- This widget uses a text input widget that will take in text from the user
- For this specific widget, it will take in the text that will be compared to a username field in the user document in Firebase
#### 3. PasswordInput Text Feild
- This widget uses an input widget that will take in text from the user
- For this specific widget, it will take in the text that will be compared to a username field in the user's document in Firebase
#### 4. Submit Button
- This is a button widget
- This button initializes the login and checks if the user with that username and password exists.
#### 5. Go to Register
- This is a link widget
- It will route the user to the registration page if clicked


### Registration
![image](https://github.com/AceLake/Assemblage-Flutter/assets/96988100/4407c35a-5637-4666-be08-624fe1550582)

#### 1. Registration body
- This is a stateless widget
- It holds all of the widgets needed for registering a user
#### 2. Username Input
- Text input widget
- The username entered will check if that is usable
- If it isn't usable it will not allow the user to use that username
- It will add a user with the given username when submitted
#### 3. Password input
- Text input widget
- The password entered will check if that is usable
- If it isn't usable it will not allow the user to use that password 
- It will add a user with the given password when submitted
#### 4. Confirm Password Input
- Text input widget
- Checks if the given password matches the initial given password
#### 5. Register Button
- This is a button widget
- This button initializes the registration and adds the user to the user's list
#### 6. Go to Login HyperLink
- This is a link widget
- It will route the user to the login page if clicked


### Home
![image](https://github.com/AceLake/Assemblage-Flutter/assets/96988100/9e925574-e2b7-416a-a717-652b20349d61)



### Find a group
![image](https://github.com/AceLake/Assemblage-Flutter/assets/96988100/1bda5071-d8c1-411a-af6f-1d9de34e166f)

### Group Info
![image](https://github.com/AceLake/Assemblage-Flutter/assets/96988100/b55d7d8c-c398-4b05-b492-88f80dc11197)

### Your Groups
![image](https://github.com/AceLake/Assemblage-Flutter/assets/96988100/58d0d8af-d7b9-4199-bb4b-34cfe7dddcb1)





