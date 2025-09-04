//
//  PlaylistView.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 25/8/2025.
//

import Foundation
import SwiftUI

/**
    The view that shows the list of playlists
 */
struct PlaylistView: View {
    @EnvironmentObject var cacher: PlaylistsViewModel
    @State private var addPlaylist: Bool = false
    @State private var newPlaylistName: String = ""
    @State private var searchString: String = ""
    
    // Formatting the date
    let formatter: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy"
        return format
    }()

    
    var body: some View {
        
        // Get the current information of the playlists saved
        var playlists = cacher.loadFromCache()
        
        /*
            Defining a variable that will hold the filtered result.
            - If the search string is currently empty, just return all playlists
            - If search string change, filter out playlists that has name containing the search string
         */
        var filteredPlaylist: [LrcGroup] {
            if searchString.isEmpty {
                return playlists
            } else {
                return cacher.filter(input: playlists, searchText: searchString)
            }
        }
        
        // The actual UI element to show the list of songs.
        NavigationStack {
            List {
                // Showing the custom view that conforms to the two column list template to show the Heading for the list
                playlistInfo(Text1: "Playlist", Text2: "Create date", font: .headline)
                    .padding(.trailing, 17.9)
                        
                // Show the actual list of playlists using the custom view, while each
                ForEach(filteredPlaylist, id: \.id) { playlist in
                        NavigationLink {
                            // Show view for each playlist (Go top the playlist detail view)
                            PlaylistDetailsView(playlist: playlist, playlistList: playlists)
                                .environmentObject(PlaylistsViewModel())
                        } label: {
                            // Showing the label using the view that conforms to the custom list
                            playlistInfo(Text1: playlist.name, Text2: formatter.string(from: playlist.creationTime))
                        }
                    }
                    // Allowing deletion to be done by swipping the list item
                    .onDelete(perform: cacher.deletePlaylist)
                    
                    // As soon as the view load up, populate the list of playlist with data saved data
                    .onAppear {
                        playlists = cacher.loadFromCache()
                    }
            }
            // Allow a search bar to show up when the user pull down the plylist list. Assisting in finding the right playlist
            .searchable(text: $searchString, prompt: "Search for playlist")
            
        }
        .navigationTitle("Playlists")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing){
                // The plus icon to add new playlist to the collection.
                Button(action: {
                    addPlaylist = true
                    
                }) {
                    Image(systemName: "plus")
                }
                // An extra view made by alert (for lightweight and clean display) for user to add in playlist name. (User can only add playlist when they give it a name)
                // User are restricted to have playlist that have different name (different capitalisation doesnt matter)
                .alert("Notification", isPresented: $addPlaylist) {
                    TextField("Name for playlist", text: $newPlaylistName)
                    Button("Add", role: .destructive) {
                        cacher.addPlaylist(name: newPlaylistName)
                        addPlaylist = false
                        newPlaylistName = ""
                    }
                    .disabled(newPlaylistName.isEmpty || cacher.checkPlaylistExist(name: newPlaylistName))
                    
                    Button("Cancel", role: .cancel){
                        addPlaylist = false
                        newPlaylistName = ""
                    }
                } message: {
                    Text("Add a new playlist")
                }
            }
        }

    }
}




struct playlistInfo: TwoColumnList {
    var Text1: String = ""
    var Text2: String = ""
    var font: Font?
}


#Preview {
    PlaylistView()
        .environmentObject(PlaylistsViewModel())
}
