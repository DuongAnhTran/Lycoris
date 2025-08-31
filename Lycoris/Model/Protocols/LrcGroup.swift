//
//  LrcGroup.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 25/8/2025.
//

import Foundation

struct LrcGroup: Codable, Identifiable, ModelTemplate {
    var id = UUID()
    var name: String
    var songList: [LrcRecord] = []
    var creationTime: Date
    
    
    mutating func clearSongs() {
        self.songList.removeAll()
    }
    
    // Functions to show the ID and the name of the playlist (for debugging)
    func showID() -> UUID {
        return self.id
    }
    
    
    func showName() -> String {
        return self.name
    }
}
