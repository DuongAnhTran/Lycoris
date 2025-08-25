//
//  LyricsViewModel.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 25/8/2025.
//



import Foundation
import SwiftUI

class LyricsViewModel: ObservableObject {
    @Published var song: LrcRecord?
    @Published var playlists: [LrcGroup] = []
    
    func addSongToPlaylist(song: LrcRecord, playlist: inout LrcGroup) {
        //Need something to stop putting the same song in the same playlist
        playlist.songList.append(song)
    }
    
}
