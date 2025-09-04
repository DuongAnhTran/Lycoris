//
//  LrcRecordLoader.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 23/8/2025.
//



/**
    A View Model/Class that is reponsible for loading the data from the API and decode it to native Swift UI format
 */


import Foundation


class LrcRecordLoader: ObservableObject {
    
    // Published variables for different types of result categorires/tabs: general query result, album name results, song name results, artist results (all in the form of list of LrcRecord)
    @Published var results: [LrcRecord] = []
    @Published var resultsAlbum: [LrcRecord] = []
    @Published var resultsSong: [LrcRecord] = []
    @Published var resultsArtist: [LrcRecord] = []
    
    // Variables to for input query string and loading state
    @Published var query: String = ""
    @Published var loading: Bool = false
    
    // Variable to determine if there is result in each of the categories
    @Published var found: Bool = true
    @Published var foundSong: Bool = true
    @Published var foundArtist: Bool = true
    @Published var foundAlbum: Bool = true
    
    
    
    // The function responsible for fetching general query results and decode it to native Swift
    /**
        The function will do the following:
            - Clean the `results` list before proceeding, and if the query string is empty then stop the function
            - If there is query, validate the URL and fetch if it is valid.
            - Decode the fetched data and transfer it to the `results` list.
            - Check if `results` is populated. If yes then set the find status `found` to true and vice versa
     */
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
    
    
    
    
    
    // The function responsible for fetching query results that matches song names and decode it to native Swift (Work similar to the general query above)
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
    
    
    
    // The function that get the results that is album related based on the query (Have to filter out from the general query since API only support general query search and song name search)
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
    
    
    // The function that get the results that is artist related based on the query (Have to filter out from the general query since API only support general query search and song name search)
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

    
    // The function that will reset all the result list (for the reset button)
    func resetResult() {
        results.removeAll()
        resultsSong.removeAll()
        resultsAlbum.removeAll()
        resultsArtist.removeAll()        
    }
    
    
    
}
