//
//  HomeView.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 23/8/2025.
//


// The opening view when user open the app
import Foundation
import SwiftUI

struct HomeView: View {
    
    @Environment(\.colorScheme) var colorScheme

    var darkMode: Bool {
        colorScheme == .dark
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Lycoris")
                    .frame(alignment: .top)
                    .font(.largeTitle)
                
                Spacer()
                // Go straight to searching lyric
                NavigationLink(destination: SearchView()) {
                    Text("Get Started")
                        .font(.title)
                        .frame(width: 180, height: 80)
                        .cornerRadius(10)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(darkMode ? .white : .black))
                        .foregroundColor(darkMode ? .black : .white)
                }
                
                // Go to the list of playlists
                NavigationLink(destination: PlaylistView().environmentObject(LrcRecordCacher())) {
                    Text("Your Playlist")
                        .font(.title)
                        .frame(width: 180, height: 80)
                        .cornerRadius(10)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(darkMode ? .white : .black))
                        .foregroundColor(darkMode ? .black : .white)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    HomeView()
}
