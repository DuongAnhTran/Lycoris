# Lycoris
A convenient and seamless application for searching and accessing song lyrics. Lycoris allows users to search, view, and save their favorite songs' lyrics directly in the application without any constraints or limitations, as long as the song has a plain text lyrics document.


## Supporting platforms:
This app mainly supports the iOS platform. However, it is also usable on iPadOS as the UI elements are also supported on that platform.


## Installation:
1. Clone the repo: `git clone https://github.com/DuongAnhTran/Lycoris.git`
2. Open the files in Xcode
3. Change the application's signings based on intended use (Either simulation or Apple devices. Please choose no signing if the app is going to run on a simulation)
4. Build and run the application.


## Dependencies:
- SwiftUI
- Minimum Deployment: (This can be changed in the code settings, depending on the usage)
  - iOS 18+
  
- External libraries and API:
  - This application utilise and collect information from [lrclib.net API](https://lrclib.net/docs).
 
## Usage Instruction:
- For Online lyrics access:
  - Open the app
  - Click on "Get Started" and start searching for you favorite song lyrics

- Searching and Saving Lyrics for offline access through caching:
  - Open the app
  - Click on "Your Playlist" and create your playlist
  - Click on the playlist and follow the prompt to navigate to search
  - Search for the song and click on the detail
  - Click add (The "+" Button on the top right) and choose the destination playlist
  - Open the playlist to access your cached lyrics!





