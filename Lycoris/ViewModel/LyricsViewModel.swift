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
    private var cacher = LrcRecordCacher()
    
    func addSongToPlaylist(song: LrcRecord, playlist: inout LrcGroup) {
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
    
    
    func removeSongfromPlaylist(index: Int, playlist: inout LrcGroup, listOfPlaylists: inout [LrcGroup]) {
        playlist.songList.remove(at: index)
        updatePlaylist(playlist: playlist, listOfPlaylist: &listOfPlaylists)
        cacher.saveToCache(playlists: listOfPlaylists)
    }
    
    
    func updatePlaylist(playlist: LrcGroup, listOfPlaylist: inout [LrcGroup]) {
        if let index = listOfPlaylist.firstIndex(where: { $0.id == playlist.id }) {
            listOfPlaylist[index] = playlist
        }
    }
    

}
