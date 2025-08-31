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
        let screen = UIScreen.main.bounds
        
        
        
        VStack {
            
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: screen.width * 0.9, height: 70)
                
                HStack(spacing: 10) {
                    Text("Select Playlist")
                    
                    Picker("Selection", selection: $selected) {
                        Text("None").tag(nil as Int?)
                        ForEach(playlists.indices, id: \.self) { index in
                            Text(playlists[index].name)
                                .tag(Optional(index))
                        }
                    }
                }
                .pickerStyle(.menu)
                .frame(width: screen.width * 0.8, height: 50)
                .background(Color.white)
            }
            
            
        
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
            .padding(.bottom, 10)
            .frame(width: screen.width * 0.4)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
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
