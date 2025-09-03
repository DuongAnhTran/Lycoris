//
//  PlaylistView.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 25/8/2025.
//

import Foundation
import SwiftUI

struct PlaylistView: View {
    @EnvironmentObject var cacher: PlaylistViewModel
    //@State var playlists: [LrcGroup] = []
    @State private var addPlaylist: Bool = false
    @State private var newPlaylistName: String = ""
    @State private var searchString: String = ""
    
    
    let formatter: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy"
        return format
    }()

    
    var body: some View {
        
        var playlists = cacher.loadFromCache()
        
        var filteredPlaylist: [LrcGroup] {
            if searchString.isEmpty {
                return playlists
            } else {
                return cacher.filter(input: playlists, searchText: searchString)
            }
        }
        
        NavigationStack {
            List {
                    playlistInfo(Text1: "Playlist", Text2: "Create date", font: .headline)
                        .padding(.trailing, 17.9)
                        
                    
                ForEach(filteredPlaylist, id: \.id) { playlist in
                        NavigationLink {
                            // Show view for each playlist
                            PlaylistDetailsView(playlist: playlist, playlistList: playlists)
                                .environmentObject(PlaylistViewModel())
                        } label: {
                            playlistInfo(Text1: playlist.name, Text2: formatter.string(from: playlist.creationTime))
                        }
                    }
                    .onDelete(perform: cacher.deletePlaylist)
                    .onAppear {
                        playlists = cacher.loadFromCache()
                    }
            }
            .searchable(text: $searchString, prompt: "Search for playlist")
            
        }
        .navigationTitle("Playlists")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing){
                Button(action: {
                    addPlaylist = true
                    
                }) {
                    Image(systemName: "plus")
                }
                // An extra view made by alert (for lightweight and clean display) for playlist name
                .alert("Notification", isPresented: $addPlaylist) {
                    TextField("Name for playlist", text: $newPlaylistName)
                    Button("Add", role: .destructive) {
                        cacher.addPlaylist(name: newPlaylistName)
                        addPlaylist = false
                        newPlaylistName = ""
                    }
                    .disabled(newPlaylistName.isEmpty)
                    
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




struct playlistInfo: TwoColumnList {
    var Text1: String = ""
    var Text2: String = ""
    var font: Font?
}


#Preview {
    PlaylistView()
        .environmentObject(PlaylistViewModel())
}
