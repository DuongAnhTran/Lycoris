//
//  SongListSearch.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 25/8/2025.
//

//Make an entire view

import Foundation
import SwiftUI


struct SongListSearch: View {
    @Binding var listContent: [LrcRecord]
    
    
    
    var body: some View {
        ForEach(listContent) { content in
            NavigationLink {
                LyricView(song: content, lyricsViewModel: LyricsViewModel())
                    .environmentObject(PlaylistViewModel())
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
        
        
        
    }
}



//Note:
//                            ForEach(loader.resultsAlbum) { song in
//                                NavigationLink {
//                                    LyricView(song: song)
//                                } label: {
//                                    VStack(alignment: .leading, spacing: 10){
//                                        Text("\(song.trackName ?? "None")")
//                                            .font(.headline)
//
//                                        Text("Artist: \(song.artistName ?? "None")")
//                                            .font(.subheadline)
//                                            .lineLimit(1)
//
//                                        Text("Album: \(song.albumName ?? "None")")
//                                            .font(.subheadline)
//                                    }
//                                }
//                            }
