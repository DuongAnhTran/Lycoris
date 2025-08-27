//
//  PlaylistDetailsView.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 25/8/2025.
//

import Foundation
import SwiftUI



struct PlaylistDetailsView: View {
    @State var playlist: LrcGroup
    @EnvironmentObject var cacher: LrcRecordCacher
    
    
    var body: some View {
        NavigationStack{
            List{
                SongListStylingView(listContent: $playlist.songList)
            }
            //This is more usable when it is used with search bar.
            //.refreshable {playlist = cacher.loadFromCache().first(where: {$0.id == playlist.id}) ?? playlist}
        }
        .navigationTitle("Playlist Details")
        
        //onAppear to update the song list. (TBH i dont know how this work - it is not supposed to, but it worked)
        .onAppear {
            let cachedPlaylists = cacher.loadFromCache()
            if let updated = cachedPlaylists.first(where: { $0.id == playlist.id }) {
                playlist = updated
            }
        }
    }
}





