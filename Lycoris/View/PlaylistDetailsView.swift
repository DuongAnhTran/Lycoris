//
//  PlaylistDetailsView.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 25/8/2025.
//

import Foundation
import SwiftUI



struct PlaylistDetailsView: View {
    var playlist: LrcGroup
    
    
    var body: some View {
        NavigationStack{
            List{
                PlaylistSongs(listContent: playlist.songList)
            }
        }
        .navigationTitle("Playlist Details")
    }
}


struct PlaylistSongs: SongDisplayTemplate {
    var listContent: [LrcRecord]
}


