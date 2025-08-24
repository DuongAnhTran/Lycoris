//
//  LrcRecordLoader.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 23/8/2025.
//


import Foundation


class LrcRecordLoader: ObservableObject {
    
    @Published var results: [LrcRecord] = []
    @Published var query: String = ""
    @Published var loading: Bool = false
    @Published var found: Bool = true
    
    
    @MainActor
    func fetchResults(query: String) async {
        loading = true
        
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
        loading.toggle()
        
        if results.isEmpty {
            found = false
        } else {
            found = true
        }
        
    }
    
    
    
    
    func filterSong() async {
        if query.isEmpty {
            results = []
        } else {
            await fetchResults(query: query)
        }
    }
    
    
}
