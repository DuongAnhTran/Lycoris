//
//  SearchView.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 23/8/2025.
//

import Foundation
import SwiftUI


struct SearchView: View {
    @StateObject var loader = LrcRecordLoader()
    @State var query = ""
    @State var clickedReset = false
    
    //For different tabs for different results:
    @State private var selectedCategory: SearchCategory = .all

    
    var body: some View {
        SearchPrimary(loader: loader, query: $query, selectedCategory: $selectedCategory, clickedReset: $clickedReset)
    }
    
}



// Enumarate for different result tabs of the search
enum SearchCategory: String, CaseIterable, Identifiable {
    case all = "All"
    case songs = "Songs"
    case artists = "Artists"
    case albums = "Albums"
    
    //Just giving a readable string as id for each case - conforming Identifiable
    var id: String { rawValue }
}


struct SecondaryView: View {
    var body: some View {
        Text("Hello")
    }
}


#Preview {
    SearchView()
}
