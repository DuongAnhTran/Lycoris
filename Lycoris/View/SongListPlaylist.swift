//
//  SongListPlaylist.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 27/8/2025.
//


import Foundation
import SwiftUI

/**
    An extra view that shows the list of songs in the chosen playlist.
        - The view takes in a copy of `lyricViewModel` to conduct song assertion and deletion (mainly deletion) directly in the list
        - Contains bindings of the chosen playlist and the actual list of playlists since any changes in the list of songs in a playlist
            also changes the lists of playlists that is getting cached into UserDefaults
        - The view also takes in the environment object PlaylistsViewModel to perform caching data into UserDefaults (UserDefaults only
            cache the list of playlists)
 */

struct SongListPlaylist: View {
    @ObservedObject var lyricsViewModel: LyricsViewModel
    @Binding var playlist: LrcGroup
    @Binding var playlistList: [LrcGroup]
    @EnvironmentObject var cacher: PlaylistsViewModel
    
    // A variable to observe user input and filter the songs in the playlist (for better access)
    @State var searchText = ""
    
    // A varible that will be storing the list of songs that will be shown based on the search text
    // Contain all of the playlist's song if the search query is none
    // Only contain songs related on then search query (song name)
    var filteredSong: [LrcRecord] {
        if searchText.isEmpty {
            return playlist.songList
        } else {
            return lyricsViewModel.filter(input: playlist, searchText: searchText)
        }
    }
    
    var body: some View {
        if !filteredSong.isEmpty {
            List {
                ForEach(Array(filteredSong.enumerated()), id: \.offset) { index, content in
                    NavigationLink {
                        LyricView(song: content, lyricsViewModel: LyricsViewModel())
                            .environmentObject(PlaylistsViewModel())
                    } label: {
                        VStack(alignment: .leading, spacing: 10){
                            Text("\(content.trackName ?? "None")")
                                .font(.headline)
                            
                            Text("Artist: \(content.artistName ?? "None")")
                                .font(.subheadline)
                                .lineLimit(1)
                            
                            Text("Album: \(content.albumName ?? "None")")
                                .font(.subheadline)
                        }
                    }
                }
                //Deleting the songs in a playlist
                .onDelete { indexSet in
                    for index in indexSet {
                        // For debugging, ensuring that the playlist getting changed is valid
                        print("Deleting song from playlist: \(playlist.showID())")
                        lyricsViewModel.removeSongfromPlaylist(index: index, playlist: &playlist, listOfPlaylists: &playlistList)
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search Songs in Playlist (by Name)")
            
        } else {
            // What will show in the song list if there is no songs (Notification and a button to go back to Home to add in song)
            Spacer()
            
            Text("There is no song in this playlist right now. Go back to home screen to add songs!")
                .bold()
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
            
            NavigationLink(destination: HomeView()) {
                Text("Home")
                    .frame(alignment: .center)
                    .foregroundStyle(Color.white)
            }
            .frame(width: 150, height: 50)
            .cornerRadius(10)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(.blue))

            Spacer ()
        }
        
        
    }
}
