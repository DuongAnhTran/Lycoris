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
    @State private var options: LyricOption = .showPlainText
    
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
                        //Do the adding
                    }) {
                        Image(systemName: "plus")
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




#Preview {
    let testSong = LrcRecord(
        id: 1,
        trackName: "Placeholder Name",
        artistName: "Placeholder Artist",
        albumName: "Placeholder Album",
        duration: 300.0,
        instrumental: false,
        plainLyrics: "Placholder plain lyrics.",
        syncedLyrics: "[00:00.00] Placeholder Lyrics."
    )
    LyricView(song: testSong)
}

