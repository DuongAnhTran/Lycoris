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
    let formatter: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy" // or any format you prefer
        return format
    }()

    
    var body: some View {
        NavigationStack {
            List {
                    playlistInfo(Text1: "Playlist", Text2: "Create date", font: .headline)
                        .padding(.trailing, 17.9)
                        
                    
                    ForEach(cacher.loadFromCache(), id: \.id) { playlist in
                        NavigationLink {
                            // Show view for each playlist
                            SongsView(songs: playlist)
                        } label: {
                            playlistInfo(Text1: playlist.name, Text2: formatter.string(from: playlist.creationTime))
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




struct playlistInfo: TwoColumnList {
    var Text1: String = ""
    var Text2: String = ""
    var font: Font?
}


#Preview {
    PlaylistView()
        .environmentObject(LrcRecordCacher())
}
