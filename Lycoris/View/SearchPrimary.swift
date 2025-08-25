//
//  SearchPrimary.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 25/8/2025.
//


import Foundation
import SwiftUI


// This is a child view of SearchView (created mainly to make it is easier to read because SearchView is too clustered)
struct SearchPrimary: View {
    
    @ObservedObject var loader: LrcRecordLoader
    @Binding var query: String
    @Binding var selectedCategory: SearchCategory
    @Binding var clickedReset: Bool
    
    var body: some View {
        NavigationStack{
            if loader.loading == false {
                
                Picker("Category", selection: $selectedCategory) {
                    ForEach(SearchCategory.allCases) { category in
                        Text(category.rawValue).tag(category)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                ZStack {
                    List {
                        switch selectedCategory {
                        case .all:
                            ForEach(loader.results) { song in
                                NavigationLink {
                                    LyricView(song: song)
                                } label: {
                                    VStack(alignment: .leading, spacing: 10){
                                        Text("\(song.trackName ?? "None")")
                                            .font(.headline)
                                        
                                        Text("Artist: \(song.artistName ?? "None")")
                                            .font(.subheadline)
                                            .lineLimit(1)
                                        
                                        Text("Album: \(song.albumName ?? "None")")
                                            .font(.subheadline)
                                    }
                                }
                            }
                        
                            
                        case .songs:
                            ForEach(loader.resultsSong) { song in
                                NavigationLink {
                                    LyricView(song: song)
                                } label: {
                                    VStack(alignment: .leading, spacing: 10){
                                        Text("\(song.trackName ?? "None")")
                                            .font(.headline)
                                        
                                        Text("Artist: \(song.artistName ?? "None")")
                                            .font(.subheadline)
                                            .lineLimit(1)
                                        
                                        Text("Album: \(song.albumName ?? "None")")
                                            .font(.subheadline)
                                    }
                                }
                            }
                            
                        case .artists:
                            ForEach(loader.resultsArtist) { song in
                                NavigationLink {
                                    LyricView(song: song)
                                } label: {
                                    VStack(alignment: .leading, spacing: 10){
                                        Text("\(song.trackName ?? "None")")
                                            .font(.headline)
                                        
                                        Text("Artist: \(song.artistName ?? "None")")
                                            .font(.subheadline)
                                            .lineLimit(1)
                                        
                                        Text("Album: \(song.albumName ?? "None")")
                                            .font(.subheadline)
                                    }
                                }
                            }
                        
                        case .albums:
                            ForEach(loader.resultsAlbum) { song in
                                NavigationLink {
                                    LyricView(song: song)
                                } label: {
                                    VStack(alignment: .leading, spacing: 10){
                                        Text("\(song.trackName ?? "None")")
                                            .font(.headline)
                                        
                                        Text("Artist: \(song.artistName ?? "None")")
                                            .font(.subheadline)
                                            .lineLimit(1)
                                        
                                        Text("Album: \(song.albumName ?? "None")")
                                            .font(.subheadline)
                                    }
                                }
                            }
                        
                            
                        }
                    }
                    .searchable(text: $query, placement: .navigationBarDrawer(displayMode: (.always)), prompt: "Search")
                        .onSubmit(of: .search) {
                            Task {
                                loader.loading = true
                                await loader.fetchResults(query: query)
                                await loader.fetchResultsSong(query: query)
                                loader.fetchResultAlbum(results: loader.results, query: query)
                                loader.fetchResultArtist(results: loader.results, query: query)
                                loader.loading = false
                               
                                print(loader.results)
                            }
                        }
                    
                    //Notification before searching and after searching for each category
                    if (loader.results.isEmpty) && (loader.found == true) {
                        HStack{
                            Text("Start searching your lyrics")
                                .font(.headline)
                            
                            Image(systemName: "magnifyingglass.circle.fill")
                                .symbolEffect(.bounce.up.wholeSymbol, options:  .repeat(.periodic(delay: 2.0)))
                        }
                    } else if (loader.found == false){
                        Text("No result found. Please search again :<")
                            .font(.headline)
                    } else {
                        switch selectedCategory {
                        case .all:
                            Text("")
                        case .songs:
                            if (!loader.foundSong) {
                                Text("No result in the category found. Please check other categories")
                                    .font(.headline)
                            } else {
                                Text("")
                            }
                        case .artists:
                            if (!loader.foundArtist) {
                                Text("No result in the category found. Please check other categories")
                                    .font(.headline)
                            } else {
                                Text("")
                            }
                        case .albums:
                            if (!loader.foundAlbum) {
                                Text("No result in the category found. Please check other categories")
                                    .font(.headline)
                            } else {
                                Text("")
                            }
                        }
                    }
                }
                //SecondaryView()
                    
            } else {
                ProgressView("Fetching your lyrics. Please wait a moment.")
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
        // Title of the view + the rest button for restting search results
        .navigationTitle("Search Lyrics")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing){
                // The reset button
                Button("Reset", action:{
                    clickedReset = true
                })
                .disabled(loader.loading == true)
                .foregroundStyle(loader.loading ? Color.gray : Color.red)
                .alert("Notification", isPresented: $clickedReset){
                    Button("Reset", role:.destructive){
                        loader.resetResult()
                        clickedReset = false
                        query = ""
                    }
                    
                    Button("No", role: .cancel){}
                } message: {
                    Text("You are resetting the search result. Are you sure?")
                }
            }
        }
    }
}
