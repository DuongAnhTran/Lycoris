//
//  PlaylistsViewModel.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 25/8/2025.
//


/**
    A view model that will be responsible for direct changes to the list of playlist (including saving the data of that the user chose to save)
    This view model also conforms to the protocol `ViewModelTemplate`
 */
import Foundation

class PlaylistsViewModel: ObservableObject, ViewModelTemplate {
    
    /// Declaring the type of Input and Output that will be using as this class conforms to `ViewModelTemplate` (for `filter` function)
    typealias Input = [LrcGroup]
    typealias Output = [LrcGroup]
    
    // A published function to keep track of the list of playlists
    @Published var playlists: [LrcGroup] = []
    
    
    // A function that will save/cache the chosen list of playlists into UserDefaults through JSON encoding
    func saveToCache (playlists: [LrcGroup]) {
        let encoder = JSONEncoder()
        if let encodeData = try? encoder.encode(playlists) {
            UserDefaults.standard.set(encodeData, forKey: "CachedPlaylist")
        }
    }
    
    // A function that will load the cache data of the list of playlists from UserDefaults, decode it and return a list of playlists ([LrcGroup])
    func loadFromCache() -> [LrcGroup] {
        if let data = UserDefaults.standard.data(forKey: "CachedPlaylist") {
            let decoder = JSONDecoder()
            if let decodeData = try? decoder.decode([LrcGroup].self, from: data) {
                return decodeData
            }
        }
        // Return nothing if the forkey does not exist
        return []
    }
    
    // A function to add playlist to the list of playlists that is cached in UserDefaults
    // First getting the current playlist list info, add a new playlist to the list and then cache it to UserDefaults
    func addPlaylist(name: String) {
        playlists = loadFromCache()
        playlists.append(LrcGroup(name: name, creationTime: Date()))
        saveToCache(playlists: playlists)
    }
    
    // A function to delete a playlist from the list of playlists and update the cached data.
    // Load the newest data from the cache, perform remove at IndexSet (this function is mainly used for list swipe delete)
    func deletePlaylist(at offsets: IndexSet) {
        playlists = loadFromCache()
        playlists.remove(atOffsets: offsets)
        saveToCache(playlists: playlists)
    }
    
    // A filter function that takes in a list of playlists and return another list of playlists that contains name related to the search query (does not take into account of capitalisation)
    func filter(input: [LrcGroup], searchText: String) -> [LrcGroup] {
        var filteredPlaylists: [LrcGroup] = []
        for playlist in input {
            if (playlist.name.lowercased().contains(searchText.lowercased())) == true {
                filteredPlaylists.append(playlist)
            }
        }
        return filteredPlaylists
    }
    
    // A function to check if a playlist already exist in the cache data. Return a corresponding boolean value as an output
    func checkPlaylistExist(name: String) -> Bool {
        let playlists = loadFromCache()
        for eachPlaylist in playlists {
            if eachPlaylist.name.lowercased() == name.lowercased()  {
                return true
            }
        }
        return false
    }
    
}
