//
//  LyricView.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 23/8/2025.
//

import Foundation
import SwiftUI



// This view show thew actual song information and the lyric of that song
struct LyricView: View {
    
    // State song varibale to recieve the song infomation from the previous view
    @State var song: LrcRecord
    
    // State to check if the user is choosing plan or synced lyrics
    @State private var options: LyricOption = .showPlainText
    
    // State variable to check if the program in in the state of adding song
    @State private var addSong: Bool = false
    
    @EnvironmentObject var cacher: PlaylistsViewModel
    
    // State variable to check if the user picked anything in the picker from the SheetView (A child view of this)
    @State private var selected: Int? = nil
    @StateObject var lyricsViewModel: LyricsViewModel
    
    // A variable to chjeck if the song exist already
    @State private var songExist: Bool = false
    
    // For dismissing the extra sheet when adding song to playlist
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        // The actual view that will show the song detail and the lyrics
        ScrollView {
            VStack(alignment: .center) {
                VStack {
                    
                    // The information of the song:
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
                
                // The side picker to choose and change between plain and synced lyric
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
                    // The plus button on the top right to add song
                    Button(action: {
                        addSong = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $addSong) {
                        // Open an extra sheet that will ask user which playlist to add the song to
                        SheetView(selected: $selected, addSong: $addSong, songExist: $songExist, lyricsViewModel: lyricsViewModel, song: song)
                            .environmentObject(PlaylistsViewModel())
                    }
                    
                    
                }
            }
        }
    }
}


// The enum created for the two options: plain lyrics and synced lyrics. This is for the alternate view when an option is picked in the horizontal picker
enum LyricOption: String, CaseIterable, Identifiable {
    var id: String {rawValue}
    
    case showPlainText = "Show Plain Text"
    case showSyncedText = "Show Synced Text"
}

