//
//  LyricsViewModel.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 25/8/2025.
//



/**
    A view model that is repsonsible for changes made to a playlist (specifically the songs in a playlist)
    This view model conforms to the `ViewModelTemplate` that contains a filter function to filter item
 **/

import Foundation
import SwiftUI

class LyricsViewModel: ObservableObject, ViewModelTemplate {
    
    /// Declaring the type of Input and Output that will be using as this class conforms to `ViewModelTemplate` (for `filter` function)
    typealias Input = LrcGroup
    typealias Output = [LrcRecord]
    
    
    private var cacher = PlaylistsViewModel()
    
    /*
        Add function was done through accessing list of playlists' indexes directly (through Picker). Therefore
        no need to take have extra statements like `removeSongfromPlaylist`
     */
    func addSongToPlaylist(song: LrcRecord, playlist: inout LrcGroup) {
        playlist.songList.append(song)
    }
    
    
    // Check if the chosen song/lyric already existed in the playlist
    func checkLyricsExist(song: LrcRecord, playlist: LrcGroup) -> Bool {
        for eachSong in playlist.songList {
            if song.id == eachSong.id  {
                return true
            }
        }
        
        return false
    }
    
    
    // The function used for deleteing a song from a playlist
    /*
        Needed to input the playlist, and list of playlist objects to manually perform changes
        due to the fact that cannot directly access them
     */
    func removeSongfromPlaylist(index: Int, playlist: inout LrcGroup, listOfPlaylists: inout [LrcGroup]) {
        playlist.songList.remove(at: index)
        updatePlaylistSong(playlist: playlist, listOfPlaylist: &listOfPlaylists)
        cacher.saveToCache(playlists: listOfPlaylists)
    }
    
    // Update the list of playlists whenever a playlist is modified
    func updatePlaylistSong(playlist: LrcGroup, listOfPlaylist: inout [LrcGroup]) {
        if let index = listOfPlaylist.firstIndex(where: { $0.id == playlist.id }) {
            listOfPlaylist[index] = playlist
        }
    }
    

    // A function to filter the result list based on the search string
    func filter(input: LrcGroup, searchText: String) -> [LrcRecord] {
        var filteredSongs: [LrcRecord] = []
        for song in input.songList {
            if (song.trackName?.lowercased().contains(searchText.lowercased()) ?? false) == true {
                filteredSongs.append(song)
            }
        }
        return filteredSongs
    }
}
