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
                
                List(loader.results) { song in
                    
                    NavigationLink {
                        LyricView(song: song)
                    } label: {
                        VStack(alignment: .leading, spacing: 10){
                            Text("\(song.trackName ?? "")")
                                .font(.headline)
                                
                            Text("\(song.artistName ?? "")")
                                .font(.subheadline)
                                .lineLimit(1)
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
