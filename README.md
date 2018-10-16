# InMoment Project
Designed and Developed a dictionary bot app as part of the take home project at InMoment. Available for both iOS and Android


## Basic idea.
- User enters a word to which they need the definition for and our robot will search for the given word.
- Our Robot has mechanical arms to turn the pages and a camera to see the words. So it can do a total of 8 tasks
as follows.
  - | S.No | Mechanical Arms (4 Tasks)  | Camera (4 Tasks)      |
    |------|----------------------------|:---------------------:|
    |  1   |    Jump to First Page      | Jump to First term    |
    |  2   |    Jump to Last Page       | Jump to Last term     |
    |  3   |    Move to Next Page       | Move to Next term     |
    |  4   |    Move to Previous Page   | Move to Previous term |
 - We need to traverse through the dictionary using these 8 operations to find the required word.
    
------
## Technical Information:
  - ### Android
    - Used Java Programming language to develop the app.
    - Used **Retrofit** Library to handle REST API calls.
    
  - ### iOS
    - Used Swift 4 Programming language to develop the app.
    - Used the **URLSessionDataTask** to handle the REST API calls.
    
 ---
 
 ## Requirements
 1. **Your app includes a text field or mechanism with which the user can enter a term.**
    - [x] *Both iOS and Android apps provided a textField for the user to enter the keyword to 
    which they need the definition.*
 
2. **Your app includes a button or mechanism with which the user can instruct the app to 
begin searching for the specified term (i.e. a “search” button)**
    - [x] *Provided a "Search" button which can be used to start the searching process.*
    
3. **When the “search” button is invoked, the app uses the provided REST API endpoints 
to attempt to locate the definition for the supplied term.**
    - [x] *Designed and implemented an algorithm which uses the provided endpoints to traverse
    across the dictionary to find the required word.*


4. **If the definition for the term is found, the app displays the definition to the user,
and allows the user to search for another term**
    - [x] *Once the definition for the required word is fetched, the results will be displayed
    in a new Fragment or new UIViewController in Android or iOS respectively.*


5. **Your app gracefully handles potential problems like slowness, network errors, internal app 
errors, and user input errors.**
    - [x] *All the possible errors will be safely handled by the app. First, the user input gets filtered
    and search process begins only when everything is fine.* 
    - [x] *App sends the request and waits for the server to respond. It notifies the user if the server
    takes a lot of time.*
    - [x] *App keeps checking for the edge (end of book, end of page) cases so that it won't get stuck in a loop.*
    - [x] *App notifies the user if any sort of network issues occur during the search process.*
    
    
6. **Your app correctly handles user interface caveats, (i.e. your app performs the action that the user 
expects when the “return” key is tapped on the keyboard)**
    - [x] *Android has a back button to hide the keyboard, however iOS doesn't. So, added a functionality such that
    user can hide the keyboard by tapping anywhere on the screen.*
    - [x] *Implemented **UITextViewDelegate** to handle keyboard "return" button taps.*
    
---   
## Bonus
-  **Progress Dialog**
    - To let the user know that the app is searching for the definition, my app shows a progress dialog. 
    - For this, I Designed & Implemented a custom progress dialog box in iOS and used the default progress
    dialog for Android app.
     
- **Cancel search**
  - Provided a cancel button so that user can interrupt the ongoing search if they wish to.
    
---
## Screenshots
### iOS
<p float="middle">
  <img src="iOS/iOS%20-%20Screenshots/iOS%20-%20Home%20Screen.png" width="200">
  <img src="iOS/iOS%20-%20Screenshots/iOS%20-%20Home%20Screen%202.png" width="200">
  <img src="iOS/iOS%20-%20Screenshots/iOS%20%20-Loading%20Screen.png" width="200">
  <img src="iOS/iOS%20-%20Screenshots/iOS%20-%20Results%20Screen.png" width="200">
</p>







