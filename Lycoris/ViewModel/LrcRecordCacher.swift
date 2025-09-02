//
//  LrcRecordCacher.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 25/8/2025.
//

import Foundation

class LrcRecordCacher: ObservableObject, ModelSavingTemplate {
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
    
}
