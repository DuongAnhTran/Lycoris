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
    
    @Published var playlists: [LrcGroup] = []
    
    func saveToCache (playlists: [LrcGroup]) {
        let encoder = JSONEncoder()
        if let encodeData = try? encoder.encode(playlists) {
            UserDefaults.standard.set(encodeData, forKey: "CachedPlaylist")
        }
    }
    
    
    func loadFromCache() -> [LrcGroup] {
        if let data = UserDefaults.standard.data(forKey: "CachedPlaylist") {
            let decoder = JSONDecoder()
            if let decodeData = try? decoder.decode([LrcGroup].self, from: data) {
                return decodeData
            }
        }
        return []
    }
    
    
    
    func addPlaylist(name: String) {
        playlists = loadFromCache()
        playlists.append(LrcGroup(name: name, creationTime: Date()))
        saveToCache(playlists: playlists)
    }
    
    
    func deletePlaylist(at offsets: IndexSet) {
        playlists = loadFromCache()
        playlists.remove(atOffsets: offsets)
        saveToCache(playlists: playlists)
    }
    

    func filter(input: [LrcGroup], searchText: String) -> [LrcGroup] {
        var filteredPlaylists: [LrcGroup] = []
        for playlist in input {
            if (playlist.name.lowercased().contains(searchText.lowercased())) == true {
                filteredPlaylists.append(playlist)
            }
        }
        return filteredPlaylists
    }
    
    
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
