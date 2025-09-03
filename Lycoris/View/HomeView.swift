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
    
    // A variable to ensure check for the current color theme of the device (light/dark)
    @Environment(\.colorScheme) var colorScheme
    var darkMode: Bool {
        colorScheme == .dark
    }
    
    var body: some View {
        NavigationStack{
            VStack {
                Spacer()
                Text("Lycoris")
                    .frame(alignment: .top)
                    .font(.largeTitle)
                    

                Image(darkMode ? "logo-walter" : "logo")
                    .padding(.bottom, 20)
                // Go to searching lyric view
                NavigationLink(destination: SearchView()) {
                    Text("Get Started")
                        .font(.title)
                        .frame(width: 180, height: 80)
                        .cornerRadius(10)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(darkMode ? .white : .black))
                        .foregroundColor(darkMode ? .black : .white)
                }
                .padding(.bottom, 20)
                
                // Go to the list of playlists
                NavigationLink(destination: PlaylistView().environmentObject(PlaylistViewModel())) {
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
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView()
}
