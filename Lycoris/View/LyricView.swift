//
//  LyricView.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 23/8/2025.
//

import Foundation
import SwiftUI


struct LyricView: View {
    
    let song: LrcRecord
    //@ObservedObject var loader: LrcRecordLoader
    @State private var options: LyricOption = .showPlainText
    @State private var addSong: Bool = false
    @EnvironmentObject var cacher: LrcRecordCacher
    @State private var selected: Int? = nil
    @StateObject var lyricsViewModel: LyricsViewModel
    
    // For the extra sheet when adding song to playl;ist
    @Environment(\.dismiss) var dismiss
    
    
    @State private var songExist: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                VStack {
                    Text("\(song.trackName ?? "No Name")")
                        .font(.title2)
                        .padding()
                    
                    Text("ID: \(song.id ?? 0)")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                    
                    Text("Artist: \(song.artistName ?? "No Info")")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                    
                    Text("Album: \(song.albumName ?? "No Info")")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                }
                
                Picker("Category", selection: $options) {
                    ForEach(LyricOption.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                switch options {
                case .showPlainText:
                    Text(song.plainLyrics ?? "No Lyrics found for this song.")
                        .font(.body)
                        .padding()

                case .showSyncedText:
                    Text(song.syncedLyrics ?? "No Synced Lyrics for this song.")
                        .font(.body)
                        .padding()

                }
                                
            }
            .navigationTitle("Song Information")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        addSong = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $addSong) {
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
                            
                            //Currently dismissing the whole view, might need to move the sheet to a new view :sob:
                            dismiss()
                        }
                    }
                    
                    
                }
            }
        }
    }
}

enum LyricOption: String, CaseIterable, Identifiable {
    var id: String {rawValue}
    
    case showPlainText = "Show Plain Text"
    case showSyncedText = "Show Synced Text"
}




//#Preview {
//    let testSong = LrcRecord(
//        id: 1,
//        trackName: "Placeholder Name",
//        artistName: "Placeholder Artist",
//        albumName: "Placeholder Album",
//        duration: 300.0,
//        instrumental: false,
//        plainLyrics: "Placholder plain lyrics.",
//        syncedLyrics: "[00:00.00] Placeholder Lyrics."
//    )
//    LyricView(song: testSong, lyricsViewModel: LyricsViewModel(), refreshID: )
//        .environmentObject(LrcRecordCacher())
//}

