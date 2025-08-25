//
//  LrcRecordCacher.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 25/8/2025.
//

import Foundation

class LrcRecordCacher: ObservableObject {
    @Published var playlist: [LrcGroup] = []
    
    func saveToCache (playlist: [LrcGroup]) {
        let encoder = JSONEncoder()
        if let encodeData = try? encoder.encode(playlist) {
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
        playlist = loadFromCache()
        playlist.append(LrcGroup(name: name, creationTime: Date()))
        saveToCache(playlist: playlist)
    }
    

    
}
