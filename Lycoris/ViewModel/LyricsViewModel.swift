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
    @Published var thePlaylist: LrcGroup?
    
    func addSongToPlaylist(song: LrcRecord, playlist: inout LrcGroup) {
        //Need something to stop putting the same song in the same playlist
        playlist.songList.append(song)
    }
    
    
    func checkLyricsExist(song: LrcRecord, playlist: LrcGroup) -> Bool {
        for eachSong in playlist.songList {
            if song.id == eachSong.id  {
                return true
            }
        }
        
        return false
    }
    
    
    
    
    
}
