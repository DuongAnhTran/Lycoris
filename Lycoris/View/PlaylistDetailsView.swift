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
    
    // This view takes information of the playlist from the PlaylistView(), along with the list of playlists (this is for later on when the user add song into the chosen playlist and have to cache the information back to user defaults)
    @State var playlist: LrcGroup
    @EnvironmentObject var cacher: PlaylistsViewModel
    @State var playlistList: [LrcGroup]
    
    
    // Declaring date format
    let formatter: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy"
        return format
    }()
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 10) {
                //The three text showing information of the chosen playlist
                Text("\(playlist.showName())")
                    .font(.title)
                    .bold()
                
                Text("Songs: \(playlist.songList.count)")
                    .font(.title2)
                
                Text("Create Date: \(formatter.string(from: playlist.creationTime))")
                    .font(.title2)
                
                // Showing the list of song in this playlist
                SongListPlaylist(lyricsViewModel: LyricsViewModel(), playlist: $playlist, playlistList: $playlistList)
                    .environmentObject(PlaylistsViewModel())

            }
            
        }
        .navigationTitle("Playlist Details")
        
        //onAppear to manually update the song list everytime it show up
        .onAppear {
            // Checking the current playlist (debug) and perform reloading playlist's detail
            print("Current playlist: \(playlist.showID()), \(playlist.showName())")
            
            /**
                Reassign data when the view is showed to ensure the data is updated:
                    - Update the playlist with the updated version as soon as it appears by reassigning
                        values for playlist and list of playlists
             */
            let cachedPlaylists = cacher.loadFromCache()
            playlistList = cacher.loadFromCache()
            if let updated = cachedPlaylists.first(where: { $0.id == playlist.id }) {
                playlist = updated
            }
        }
    }
}





