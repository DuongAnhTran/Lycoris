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
    
    mutating func addSongtoPlaylist(_ song: LrcRecord) {
        self.songList.append(song)
    }
    
    
    mutating func clearSongs() {
        self.songList.removeAll()
    }
    
    //Remove song will be done directly in the playlist view
    
    
    func showID() {
        print("\(self.id)")
    }
}
