//
//  LyricsViewModel.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 25/8/2025.
//



/**
    A view model that is repsonsible for changes made to a playlist (specifically the songs in a playlist)
    This view model conforms to the `ViewModelTemplate` that contains a filter function to filter item
 
    There are no @Published variable since there is cases where @Published can be desync in the actual view if the view has multiple childviews doing different jobs. Additionally, there are cases where these child view can receive the copy of the varibles instead of being able to directly access them. Hence, there is no @Publ;ished varibles, and each function in this View Model will receive input paramters (directly from the view when called) instead.
 **/

import Foundation
import SwiftUI

class LyricsViewModel: ObservableObject, ViewModelTemplate {
    
    /// Declaring the type of Input and Output that will be using as this class conforms to `ViewModelTemplate` (for `filter` function)
    typealias Input = LrcGroup
    typealias Output = [LrcRecord]
    
    // This is an instace of PlaylistViewModel for this View Model to use and cache the data changes when needed
    private var cacher = PlaylistsViewModel()
    
    
    /**
        Add function was done through accessing list of playlists' indexes directly (using Picker in `SheetView`). Therefore
        no need to take have extra statements like `removeSongfromPlaylist`
     */
    func addSongToPlaylist(song: LrcRecord, playlist: inout LrcGroup) {
        playlist.songList.append(song)
    }
    
    
    // Check if the chosen song/lyric already existed in the playlist and return a boolean value
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
    
    
    // Update the list of playlists whenever a playlist is modified from the song list
    // This is needed in some cases where the view doesn't have direct access to the playlists (or only have a copy of playlists)
    func updatePlaylistSong(playlist: LrcGroup, listOfPlaylist: inout [LrcGroup]) {
        if let index = listOfPlaylist.firstIndex(where: { $0.id == playlist.id }) {
            listOfPlaylist[index] = playlist
        }
    }
    

    // A function to filter the result list based on the search string
    // The function takes in the input (playlist), which will be directly provided from the view and return the list of songs that contains the given search query
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
