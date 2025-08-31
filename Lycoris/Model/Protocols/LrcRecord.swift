//
//  LrcRecord.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 23/8/2025.
//


import Foundation

struct LrcRecord: Codable, Identifiable, ModelTemplate {
    let id: Int?
    let trackName: String?
    let artistName: String?
    let albumName: String?
    let duration: Double?
    let instrumental: Bool?
    let plainLyrics: String?
    let syncedLyrics: String?
    
    
    // Functions to show the ID and the Name of the song (for debugging)
    func showID() -> Int {
        return self.id ?? 0
    }
    
    func showName() -> String {
        return self.trackName ?? "Track name not available"
    }
    
}
