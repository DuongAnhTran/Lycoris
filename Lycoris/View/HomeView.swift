//
//  HomeView.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 23/8/2025.
//

import Foundation
import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack{
            NavigationLink(destination: SearchView()) {
                Text("Get Started")
                    .font(.title)
                    .frame(width: 180, height: 80)
                    .cornerRadius(10)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(.black))
                    .foregroundColor(.white)
            }
            NavigationLink(destination: PlaylistView().environmentObject(LrcRecordCacher())) {
                Text("Your Playlist")
                    .font(.title)
                    .frame(width: 180, height: 80)
                    .cornerRadius(10)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(.black))
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    HomeView()
}
