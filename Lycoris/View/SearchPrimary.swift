//
//  SearchPrimary.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 25/8/2025.
//


import Foundation
import SwiftUI


// This is a child view of SearchView (created mainly to make it is easier to read because SearchView is too clustered)
// This view will contain the picker, the list of result song and the search bar UI element
struct SearchPrimary: View {
    
    @ObservedObject var loader: LrcRecordLoader
    
    // Getting the information the current query, the selected category and status on whether the user want search resuklt clear from the parent view SearchVioew()
    @Binding var query: String
    @Binding var selectedCategory: SearchCategory
    @Binding var clickedReset: Bool
    
    var body: some View {
        Group {
            NavigationStack{
                if loader.loading == false {
                    
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(SearchCategory.allCases) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                    
                    ZStack {
                        List {
                            // Show the list of songs resukted in the four categories of search using a child view named SongListSearch()
                            switch selectedCategory {
                            case .all:
                                SongListSearch(listContent: $loader.results)
                                    
                                
                            case .songs:
                                SongListSearch(listContent: $loader.resultsSong)
                                    
                                
                            case .artists:
                                SongListSearch(listContent: $loader.resultsArtist)
                                    
                                
                            case .albums:
                                SongListSearch(listContent: $loader.resultsAlbum)
                            }
                        }
                        //Search bar setting for the result list
                        .searchable(text: $query, placement: .navigationBarDrawer(displayMode: (.always)), prompt: "Search")
                        
                        /**
                            When submit the query on the search bar (by clicking `Enter`):
                                - Set the loading state to true
                                - Fetch results from API by searching using `general query - q` and `track name` (API restriction)
                                - Get all the information and sort it out for album and artist results
                                - When done reset the loading state
                         */
                        .onSubmit(of: .search) {
                            Task {
                                loader.loading = true
                                await loader.fetchResults(query: query)
                                await loader.fetchResultsSong(query: query)
                                loader.fetchResultAlbum(results: loader.results, query: query)
                                loader.fetchResultArtist(results: loader.results, query: query)
                                loader.loading = false
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
                        // Show the notification if there is no result can be found for any of the tab
                        } else if (loader.found == false){
                            Text("No result found. Please search again :<")
                                .font(.headline)
                        } else {
                            // Four different views for 4 different tabs of results
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
                    
                // Activate progressing view everytime query is submitted.
                } else {
                    ProgressView("Fetching your lyrics. Please wait a moment.")
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }
            // Title of the view + the rest button for restting search results
            .navigationTitle("Search")
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
}




