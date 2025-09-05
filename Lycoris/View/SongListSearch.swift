//
//  SongListSearch.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 25/8/2025.
//


import Foundation
import SwiftUI

// A song list view for song searching
struct SongListSearch: View {
    // A variable to get the search results and display it in a list (obtained the info from the parent view SearchPrimary())
    @Binding var listContent: [LrcRecord]
    
    var body: some View {
        // Each item of the list naviogate to a separate view to show the information of the song and also the lyrics
        ForEach(listContent) { content in
            NavigationLink {
                LyricView(song: content, lyricsViewModel: LyricsViewModel())
                    .environmentObject(PlaylistsViewModel())
            } label: {
                // Label for the list item: Includes track name, artist name and album
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
