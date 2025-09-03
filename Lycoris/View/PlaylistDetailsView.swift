//
//  PlaylistDetailsView.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 25/8/2025.
//

import Foundation
import SwiftUI


// The view that show the detail of the chosen playlist
struct PlaylistDetailsView: View {
    @State var playlist: LrcGroup
    @EnvironmentObject var cacher: PlaylistViewModel
    @State var playlistList: [LrcGroup]
    @State var empty: Bool = false
    
    // Declaring date format
    let formatter: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy"
        return format
    }()
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 10) {
                Text("Playlist: \(playlist.showName())")
                    .font(.title2)
                
                Text("Songs: \(playlist.songList.count)")
                    .font(.title2)
                
                Text("Create Date: \(formatter.string(from: playlist.creationTime))")
                    .font(.title2)
                
                //List{
                SongListPlaylist(lyricsViewModel: LyricsViewModel(), playlist: $playlist, playlistList: $playlistList)
                    .environmentObject(PlaylistViewModel())
                //}
            }
            
        }
        .navigationTitle("Playlist Details")
        
        //onAppear to manually update the song list everytime it show up
        .onAppear {
            // Checking the current playlist (debug) and perform reloading playlist's detail
            print("Current playlist: \(playlist.showID()), \(playlist.showName())")
            
            // Reassign data when the view is showed to ensure the data is updated
            let cachedPlaylists = cacher.loadFromCache()
            playlistList = cacher.loadFromCache()
            if let updated = cachedPlaylists.first(where: { $0.id == playlist.id }) {
                playlist = updated
            }
        }
    }
}





