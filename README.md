# InMoment Project
Designed and Developed a dictionary bot app as part of the take home project at InMoment. Available for both iOS and Android


## Basic idea.
- User enters a word to which they need the definition for and our robot will search for the given word.
- Our Robot has mechanical arms to turn the pages and a camera to see that words. So it can do a total of 8 tasks.
  - | S.No | Mechanical Arms (4 Tasks)  | Camera (4 Tasks)      |
    |------|----------------------------|:---------------------:|
    |  1   |    Jump to First Page      | Jump to First term    |
    |  2   |    Jump to Last Page       | Jump to Last term     |
    |  3   |    Move to Next Page       | Move to Next term     |
    |  4   |    Move to Previous Page   | Move to Previous term |
 - We need to traverse through the definition using these 8 operations to find the required word.
    
------
## Technical Information:
  - ### Android
    - Used Java programming language to develop the app.
    - Used Retrofit Library to handle REST API calls.
    
  - ### iOS
    - Used Swift 4 Programming language to develop the app.
    - Used the URLSessionDataTask to handle the REST API Calls.
    
 ---
 
 ## Requirements
 1. **Your app includes a text field or mechanism with which the user can enter a term.**
    - [x] *Both iOS and Android provide a textField for the user to enter the keyword to 
    which they need the definition.*
 
2. **Your app includes a button or mechanism with which the user can instruct the app to 
begin searching for the specified term (i.e. a “search” button)**
    - [x] *Provided a "Search" button which can be used to start the searching process.*
    
3. **When the “search” button is invoked, the app uses the provided REST API endpoints 
to attempt to locate the definition for the supplied term.**
    - [x] *Designed and implemented an algorithm which uses the provided end points to traverse
    across the dictionary to find the required word.*


4. **If the definition for the term is found, the app displays the definition to the user,
and allows the user to search for another term**
    - [x] *Once the app finds the definition for the required word, the results will be displayed
    in a new Fragment or new UIViewController in Android or iOS respectively.*


5. **Your app gracefully handles potential problems like slowness, network errors, internal app 
errors, and user input errors.**
    - [x] *All the possible errors will be safely handled by the app. First the user input gets fileterd
    and search process begins only when everything is fine.* 
    - [x] *App keeps checking for the edge cases so that it won't get stuck in a loop.*
    - [x] *App notifies the user if any sort of network issues occur during the search process.*
    - [x] *App waits for a good amount of time for the server to respond and notifies the user if the server
    takes a lot of time.*
    
6. **Your app correctly handles user interface caveats, (i.e. your app performs the action that the user 
expects when the “return” key is tapped on the keyboard)**
    - [x] *Android has a back button to hide the keyboard, however iOS doesn't. So, added a funtionality such that
    user can hide the keyboard by tapping anywhere on the screen.*
    - [x] *Implemented **UITextViewDelegate** to handle "return" button taps.*
    
 ---   
## Bonus
-  **Progress Dialog**
    - To let user know that the app is searching for the definition, my app shows a progress dialog. 
    - Implemented my own custom progress dialog box in iOS and used the default progress dialog for Android app.
     
- **Cancel search**
  - Provided a cancel button so that user can cancel the ongoing search if they wish to.
    
