//
//  SongListPlaylist.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 27/8/2025.
//


import Foundation
import SwiftUI


struct SongListPlaylist: View {
    @ObservedObject var lyricsViewModel: LyricsViewModel
    @Binding var playlist: LrcGroup
    @Binding var playlistList: [LrcGroup]
    @EnvironmentObject var cacher: LrcRecordCacher
    
    var body: some View {
        ForEach(Array(playlist.songList.enumerated()), id: \.offset) { index, content in
            
            NavigationLink {
                LyricView(song: content, lyricsViewModel: LyricsViewModel())
                    .environmentObject(LrcRecordCacher())
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
        //Deleting the songs in a playlist
        .onDelete { indexSet in
            for index in indexSet {
                // For debugging, ensuring that the playlist getting changed is valid
                print("Deleting song from playlist: \(playlist.showID())")
                lyricsViewModel.removeSongfromPlaylist(index: index, playlist: &playlist, listOfPlaylists: &playlistList)
            }
        }
            
        
    }
}
