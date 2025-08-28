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
    @EnvironmentObject var cacher: LrcRecordCacher
    @Binding var selected: Int?
    @Binding var addSong: Bool
    @ObservedObject var lyricsViewModel: LyricsViewModel
    @State var song: LrcRecord
    @Binding var songExist: Bool
    
    
    var body: some View {
        var playlists = cacher.loadFromCache()
        Picker("Select Playlist", selection: $selected) {
            ForEach(playlists.indices, id: \.self) { index in
                Text(playlists[index].name)
                    .tag(index)
            }
        }
        .pickerStyle(.menu)
        
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
        .disabled(selected == nil)
        .alert("Song already exist, do you still want to add?", isPresented: $songExist) {
            Button ("Add", role: .destructive) {
                // Ensure that adding is done to a valid song and adding to valid playlist, can force unwrap because validated before
                print("Adding to playlist ID: \(playlists[selected!].showID())")
                print("Adding song: \(song.showID())")
                songExist = false
                lyricsViewModel.addSongToPlaylist(song: song, playlist: &playlists[selected!])
                cacher.saveToCache(playlists: playlists)
                addSong = false
                selected = nil
            }
            
            Button("Cancel", role: .cancel) {
                addSong = false
                songExist = false
            }
        }
        Button("Cancel", role: .cancel) {
            
            
            dismiss()
        }
    }
}
