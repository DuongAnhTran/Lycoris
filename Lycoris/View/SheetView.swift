//
//  SheetView.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 27/8/2025.
//

import Foundation
import SwiftUI

struct SheetView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var cacher: PlaylistsViewModel
    @Binding var selected: Int?
    @Binding var addSong: Bool
    @ObservedObject var lyricsViewModel: LyricsViewModel
    @State var song: LrcRecord
    @Binding var songExist: Bool
    
    // Environment variable that observe the current color theme of the device
    @Environment(\.colorScheme) var colorScheme
    
    // A variable to check if the current theme is dark
    var darkMode: Bool {
        colorScheme == .dark
    }
    
    
    var body: some View {
        // A playlist variable that will be holding the information of all the playlists saved (for internal use only)
        var playlists = cacher.loadFromCache()
        
        // A variable that will ber observing the screen ratio and propotion
        let screen = UIScreen.main.bounds
        
        VStack {
            // Display the picker that prompt and ask the user which playlist to save the song to
            // The picker will be put in a gray box with 2 button to either add or cancel the adding process
            Form {
                Picker("Selection", selection: $selected) {
                    Text("None").tag(nil as Int?)
                    ForEach(playlists.indices, id: \.self) { index in
                        Text(playlists[index].name)
                            .tag(Optional(index))
                    }
                }
                .pickerStyle(.menu)
                .accentColor(darkMode ? Color.white : Color(hex: 0x696969))
                .frame(width: screen.width * 0.8, height: 50)
                .listRowBackground(darkMode ? Color.gray : Color(hex: 0xFAFAFA))
            }
            .frame(height: 140)
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)


            // Add button to add song to the chosen playlist
            // This button will show an alert if the playlist already contain the song
            Button("Add", role: .destructive) {
                if selected != nil {
                    guard playlists.indices.contains(selected!) else {
                        addSong = false
                        return
                    }
                    if (lyricsViewModel.checkLyricsExist(song: song, playlist: playlists[selected!])) {
                        songExist = true
                    } else {
                        songExist = false
                        lyricsViewModel.addSongToPlaylist(song: song, playlist: &playlists[selected!])
                        cacher.saveToCache(playlists: playlists)
                        addSong = false
                        selected = nil
                    }
                }
            }
            .font(.headline)
            .padding()
            .frame(width: screen.width * 0.4)
            .background((selected == nil) ? Color.gray : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .disabled(selected == nil)
            
            // The alert contains the notification noticing the user that the song is already in the playlist
            // This alert has two button, either to cancel the process or proceed on adding
            .alert("Song already exist, do you still want to add?", isPresented: $songExist) {
                Button ("Add", role: .destructive) {
                    // Ensure that adding is done to a valid song and adding to valid playlist, can force unwrap because validated before
                    print("Adding to playlist ID: \(playlists[selected!].showID())")
                    print("Adding song: \(song.showID())")
                    songExist = false
                    addSongAndCache(song: song, playlist: &playlists[selected!], playlists: playlists)
                    addSong = false
                    selected = nil
                }
                
                Button("Cancel", role: .cancel) {
                    addSong = false
                    songExist = false
                }
            }
            
            // The button to cancel adding process
            Button("Cancel", role: .cancel) {
                selected = nil
                dismiss()
            }
            .font(.headline)
            .padding()
            .frame(width: screen.width * 0.4)
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
            
        }
    }
    
    
    /// An extra function to do both adding and caching at the same time directly without the need to use `updatePlaylistSong`
    ///     like when deleting (since in this case, the playlist is accessed using index directly through list of playlists (`playlists`). In the case of deleting, this is provided. Therefore need to explicitly use update function)
    func addSongAndCache(song: LrcRecord, playlist: inout LrcGroup, playlists: [LrcGroup]) {
        lyricsViewModel.addSongToPlaylist(song: song, playlist: &playlist)
        cacher.saveToCache(playlists: playlists)
    }
    
}
