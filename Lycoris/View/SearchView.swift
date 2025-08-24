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
    
    var body: some View {
        NavigationStack{
            if loader.loading == false {
                ZStack {
                    List(loader.results) { song in
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
                    .searchable(text: $query, placement: .navigationBarDrawer(displayMode: (.always)), prompt: "Search")
                    .onSubmit(of: .search) {
                        Task {
                            await loader.fetchResults(query: query)
                            print(loader.results)
                        }
                    }
                    
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
                    }
                }

            } else {
                ProgressView("I'm Loading chill out cuh...")
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
        
    }
    
}



#Preview {
    SearchView()
}
