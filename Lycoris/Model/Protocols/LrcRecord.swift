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
    
    func showID() {
        print("\(self.id ?? 0)")
    }
}
