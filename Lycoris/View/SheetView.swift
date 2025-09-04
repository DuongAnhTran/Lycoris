//
//  SheetView.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 27/8/2025.
//

import Foundation
import SwiftUI

struct SheetView: View {
    
    // Variable to dismiss the sheet
    @Environment(\.dismiss) var dismiss
    
    // Variable to access cacher and functions
    @EnvironmentObject var cacher: PlaylistsViewModel
    
    // Binding variables to check the current situation of the picker (if user chose a playlist to save song or not), the current situation whether if the user is adding a song (when click the 'add' button), and the status to whether if the chosen song already exist
    @Binding var selected: Int?
    @Binding var addSong: Bool
    @Binding var songExist: Bool
    
    // Variable for Lyric View Model and a State variable to get the song chosen from LyricView
    @ObservedObject var lyricsViewModel: LyricsViewModel
    @State var song: LrcRecord
    
    
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
            // This button will show an alert if the playlist already contain the song. But still add if the user insist
            Button("Add", role: .destructive) {
                // Only enable if there is a playlist chosen in the picker
                if selected != nil {
                    // Stop the process if the selected index from picker is not matching with the playlist list
                    guard playlists.indices.contains(selected!) else {
                        addSong = false
                        return
                    }
                    
                    // Check whether the chosen song is already existing. Yes -> Open alert. No -> Add right away
                    if (lyricsViewModel.checkLyricsExist(song: song, playlist: playlists[selected!])) {
                        songExist = true
                    } else {
                        // Ensure the song added is right
                        print("Adding to playlist ID: \(playlists[selected!].showID())")
                        print("Adding song: \(song.showID())")
                        // In this case, the playlist is accessed using index directly through list of playlists (`playlists`). Therefore no need to use the update function in LyricsViewModel (only for deleting case where playlist cannot be directly accessed)
                        // Reset status variables, while also adding the song
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
                    // In this case, the playlist is accessed using index directly through list of playlists (`playlists`). Therefore no need to use the update function in LyricsViewModel (only for deleting case where playlist cannot be directly accessed)
                    // Reset status variables, while also adding the song
                    songExist = false
                    lyricsViewModel.addSongToPlaylist(song: song, playlist: &playlists[selected!])
                    cacher.saveToCache(playlists: playlists)
                    addSong = false
                    selected = nil
                }
                
                // Cancel and close the alert
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
}
