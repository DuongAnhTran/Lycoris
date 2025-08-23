//
//  LrcRecordLoader.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 23/8/2025.
//


import Foundation

@Observable
class LrcRecordLoader: ObservableObject {
    
    func fetchResults(query: String) async throws -> [LrcRecord] {
        var comps = URLComponents(string: "https://lrclib.net/api/search")!
        comps.queryItems = [URLQueryItem(name: "q", value: query)]
        
        guard let url = comps.url else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode([LrcRecord].self, from: data)
        
        return decoded
    }
}
