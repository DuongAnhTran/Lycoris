//
//  SongsView.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 25/8/2025.
//




import Foundation
import SwiftUI


struct SongsView: View {
    let songs: LrcGroup
    
    var body: some View {
        Text(songs.name)
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
