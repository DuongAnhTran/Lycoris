//
//  LycorisApp.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 23/8/2025.
//

import SwiftUI
// The file that will initiate the start of the app and also feed in the environment variable PlaylistsViewModel for ContentView and other views that is related to it to use

@main
struct LycorisApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(PlaylistsViewModel())
        }
    }
}
