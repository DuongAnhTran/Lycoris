//
//  PlaylistView.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 25/8/2025.
//

import Foundation
import SwiftUI

struct PlaylistView: View {
    @EnvironmentObject var cacher: LrcRecordCacher
    @State var playlists: [LrcGroup] = []
    @State private var addPlaylist: Bool = false
    @State private var newPlaylistName: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(cacher.loadFromCache(), id: \.id) { playlist in
                    NavigationLink {
                        // Show view for each playlist
                        Text(playlist.name)
                    } label: {
                        Text("\(playlist.name)")
                            .font(.headline)
                    }
                }
            }
            
        }
        .navigationTitle("Search Lyrics")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing){
                Button(action: {
                    addPlaylist = true
                    
                }) {
                    Image(systemName: "plus")
                }
                .alert("Notification", isPresented: $addPlaylist) {
                    TextField("Name for playlist", text: $newPlaylistName)
                    Button("Add", role: .destructive) {
                        cacher.addPlaylist(name: newPlaylistName)
                        addPlaylist = false
                        newPlaylistName = ""
                    }
                    Button("Cancel", role: .cancel){
                        addPlaylist = false
                        newPlaylistName = ""
                    }
                } message: {
                    Text("Add a new playlist")
                }
            }
        }

    }
}



#Preview {
    PlaylistView()
        .environmentObject(LrcRecordCacher())
}
