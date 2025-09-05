# Lycoris
A convenient and seamless application for searching and accessing song lyrics. Lycoris allows users to search, view, and save their favorite songs' lyrics directly in the application without any constraints or limitations, as long as the song has a plain text lyrics document. The goal of this app is to create an app that make up for the lack of mobile lyrics finder, specifically apps that are fully built for iOS devices. 

All version and commit history for **Lycoris** will be found on this ([GitHub repo link](https://github.com/DuongAnhTran/Lycoris.git))

## Main processes
The presented version of this application is a minimum viable product version, containing these main functionalities:
- Search for lyrics
- Viewing song lyrics and information
- Create/Delete playlists
- Add/Delete lyrics to/from created playlists
- Access lyrics offline after adding them to the playlist (cached into UserDefaults)

## Team member(s):
- Duong Anh Tran (24775456)


## Supporting platforms:
This app mainly supports the iOS platform. However, it is also usable on iPadOS as the UI elements are supported on that platform.


## Installation:
1. Clone the repo: `git clone https://github.com/DuongAnhTran/Lycoris.git`
2. Open the files in Xcode
3. Change the application's signings (Located in `Signing and Capabilities`) based on intended use (Either simulation or Apple devices. Please choose no signing if the app is going to run on a simulation)
4. Build and run the application.


## Dependencies:
- Swift/SwiftUI
- Minimum Deployment: (This can be changed in the code settings, depending on the usage)
  - iOS 17+
  
- External libraries and API:
  - This application utilise and collect information from [lrclib.net API](https://lrclib.net/docs).
 
## Usage Instruction:
1. For Online lyrics access:
  - Open the app
  - Click on "Get Started" and start searching for you favorite song lyrics

2. Searching and Saving Lyrics for offline access through caching:
  - Open the app
  - Click on "Your Playlist" and create your playlist
  - Click on the playlist and follow the prompt to navigate to search
  - Search for the song and click on the detail
  - Click add (The "+" Button on the top right) and choose the destination playlist
  - Open the playlist to access your cached lyrics!

Note: The user need to make a playlist before they want to save songs to access them offline


# Application analysis (Extra section):
## Object-Oriented Concepts:
In the development of the application, Object-Oriented are highlighted through the fact that `ViewModel` instances are created in Views and used to perform specific tasks and processes in the application. For example, `PlaylistViewModel` contains functions that responsible for managing playlists in the list of user's playlists (which is getting cached into UserDefaults). This ViewModel also have an instance of `[LrcGroup]` instance (or instance of list of playlists). Using this, it allows `PlaylistViewModel` to manage and list of playlists throughout the views in the application.

## Protocol-Oriented Elements:
In terms of Protocol-Oriented design, some custom protocols were created to not only support the creation and management of the classes/structures with similar concept, it also allows custom creation of view and UI elements.

These are the protocols that are used for the application. They are saved in the `Protocol` folder that corresponding to their roles. For example, if the protocol is used for Model, it will be in the `Protocol` folder in the `Model` file.
- `ModelTemplate`: Classes that conforms to this protocol are the models of the application. This app has 2 functions returning name and ID of the object. This protocol is mainly created for `Model` since it provide debugging functions that can be used throughout the application to observe and validate the functions and processes of the app

- `TwoColumnList`: This is a protocol that contains an extension being a mini View, which can be used to display the information in the form of two columns. This is used when there is a need of a two-column list in the view (the display of user's list of playlists, where the list show the name and the creation date of the playlists)

- `ViewModelTemplate`: This is a protocol for application's view model where these classes are making changes to the models, or the data getting cached, which is in the form of `[LrcGroup]`. These classes will have a common function `filter` that will help filtering the the object (playlist or song lyrics) by names, assisting in providing better navigation for user when they access their saved lyrics.

## User Interface:
The User Interface is keep simple but intuitive. For buttons that are related to tasks, it would be in the standard blue color. However, other buttons that does risky/redundant tasks (such as adding the same song to a playlist and reset result button) is given the red color to notice the user, even if the process the user going to make is allowed, just a bit redundant.

Button will be gray out and disable when the user do not pick a playlist to save the lyrics, or adding a playlist with the same name into the system. These gray-ed out button will notice the user that they are either not putting in enough information or putting in an information that can be redundant.

## Error Handling:
The UI elements of the application is disabled if the user is inputting a redundant information or missing a required field. This has been mentioned in `User Interface` and the button design. Besides, internally, when fetching for the API results, `if let`, `guard` and `do-catch blocks` are used to ensure that the information gathered and the decoding process is smoothly done. Additionally, optionals are also unwrapped with the mentioned code block, unless it is guaranteed to not be null or nil.

## Testing and Debugging:
In terms of the testing process of the application `LycorisTests.swift` contains the unit tests that are used to test the main processes in the application, ensuring that they are working as expected in all situation. These unit tests don't just test a function, they test a processes that contains multiple call of functions, aiming to accomplish a task. Additional information can be found in the swift file in the project under `LycorisTests` folder.





