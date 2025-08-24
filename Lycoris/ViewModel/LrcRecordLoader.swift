//
//  LrcRecordLoader.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 23/8/2025.
//


import Foundation


class LrcRecordLoader: ObservableObject {
    
    @Published var results: [LrcRecord] = []
    @Published var resultsAlbum: [LrcRecord] = []
    @Published var resultsSong: [LrcRecord] = []
    @Published var resultsArtist: [LrcRecord] = []
    
    @Published var query: String = ""
    @Published var loading: Bool = false
    @Published var found: Bool = true
    @Published var foundSong: Bool = true
    @Published var foundArtist: Bool = true
    @Published var foundAlbum: Bool = true
    
    
    
    func fetchResults(query: String) async {
        results.removeAll()
        
        
        if query == "" {
            self.results = []
            return
        }
        
        var comps = URLComponents(string: "https://lrclib.net/api/search")!
        comps.queryItems = [URLQueryItem(name: "q", value: query)]
        
        guard let url = comps.url else {
            self.results = []
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode([LrcRecord].self, from: data)
            self.results = decoded
        } catch {
            self.results = []
            print("Error fetching or decoding: \(error)")
        }
       
        
        if results.isEmpty {
            found = false
        } else {
            found = true
        }
    }
    
    
    
    
    
    
    func fetchResultsSong(query: String) async {
        resultsSong.removeAll()
        
        
        if query == "" {
            self.resultsSong = []
            return
        }
        
        var comps = URLComponents(string: "https://lrclib.net/api/search")!
        comps.queryItems = [URLQueryItem(name: "track_name", value: query)]
        
        guard let url = comps.url else {
            self.resultsSong = []
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode([LrcRecord].self, from: data)
            self.resultsSong = decoded
        } catch {
            self.resultsSong = []
            print("Error fetching or decoding: \(error)")
        }
        
        
        if resultsSong.isEmpty {
            foundSong = false
        } else {
            foundSong = true
        }
    
    }
    
    
    
    
    func fetchResultAlbum(results: [LrcRecord], query: String) {
        resultsAlbum.removeAll()
        
        for song in self.results {
            if song.albumName?.lowercased().contains(query.lowercased()) == true {
                resultsAlbum.append(song)
            }
        }
        
        if resultsAlbum.isEmpty {
            foundAlbum = false
        } else {
            foundAlbum = true
        }
    }
    
    
    
    func fetchResultArtist(results: [LrcRecord], query: String) {
        resultsArtist.removeAll()
        
        for song in self.results {
            if song.artistName?.lowercased().contains(query.lowercased()) == true {
                resultsArtist.append(song)
            }
        }
        
        if resultsArtist.isEmpty {
            foundArtist = false
        } else {
            foundArtist = true
        }
    }

    
    
    
}
