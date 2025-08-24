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
    
    var body: some View {
        ScrollView {
            
            
            VStack(alignment: .center) {
                Text("\(song.trackName ?? "No Name")")
                    .font(.title2)
                HStack{
                    Text("Artist: \(song.artistName ?? "No Info")")
                        .font(.headline)
                    Text("Album: \(song.albumName ?? "No Info")")
                        .font(.headline)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Song Information")
                        .font(.largeTitle)
                        .padding()
                }
            }
        }
    }
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

