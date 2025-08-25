//
//  LycorisApp.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 23/8/2025.
//

import SwiftUI

@main
struct LycorisApp: App {
    
    @StateObject private var dataCache = LrcRecordCacher()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataCache)
        }
    }
}
