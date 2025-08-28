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
    @State var playlistList: [LrcGroup]
    
    var body: some View {
        NavigationStack{
            List{
                SongListPlaylist(lyricsViewModel: LyricsViewModel(), playlist: $playlist, playlistList: $playlistList)
                    .environmentObject(LrcRecordCacher())
            }
            //This is more usable when it is used with search bar.
            //.refreshable {playlist = cacher.loadFromCache().first(where: {$0.id == playlist.id}) ?? playlist}
        }
        .navigationTitle("Playlist Details")
        
        //onAppear to update the song list. (TBH i dont know how this work - it is not supposed to, but it worked)
        .onAppear {
            // Checking the current playlist (debug) and perform reloading playlist's detail
            print("Current playlist's ID: \(playlist.showID())")
            let cachedPlaylists = cacher.loadFromCache()
            playlistList = cacher.loadFromCache()
            if let updated = cachedPlaylists.first(where: { $0.id == playlist.id }) {
                playlist = updated
            }
        }
    }
}





