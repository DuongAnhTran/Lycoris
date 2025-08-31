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
    
    mutating func addSongtoPlaylist(_ song: LrcRecord) {
        self.songList.append(song)
    }
    
    
    mutating func clearSongs() {
        self.songList.removeAll()
    }
    
    //Remove song will be done directly in the song view
    
    
    func showID() -> UUID {
        return self.id
    }
    
    func showName() -> String {
        return self.name
    }
}
