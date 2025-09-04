//
//  LycorisTests.swift
//  LycorisTests
//
//  Created by Dương Anh Trần on 23/8/2025.
//

import XCTest
@testable import Lycoris

final class LycorisTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // Testing add playlist process
    func testAddPlaylist() throws {
        let cacher = PlaylistsViewModel()
        let initialCount = cacher.loadFromCache().count

        cacher.addPlaylist(name: "Testing")

        XCTAssertEqual(cacher.loadFromCache().count, initialCount + 1)
        XCTAssertEqual(cacher.playlists.last?.name, "Testing")
    }
    
    // Testing add song process
    func testAddSong() throws {
        let lyricVM = LyricsViewModel()
        let cacher = PlaylistsViewModel()
        var playlists = cacher.loadFromCache()
        var playlist = playlists.first(where: {$0.name == "Testing"})!
        let initialCount = playlist.songList.count
        let song =  LrcRecord(
            id: 0,
            trackName: "Testing",
            artistName: "Testing",
            albumName: "Testing",
            duration: 0.00,
            instrumental: false,
            plainLyrics: "Testing Lyrics",
            syncedLyrics: "Testing Synced Lyrics"
        )
        
        /// When adding the song into playlist in the actual app, `updatePlaylistSong` wasn't needed as the the playlist is accessed through the index of `playlists` (list of playlists)
        lyricVM.addSongToPlaylist(song: song, playlist: &playlist)
        lyricVM.updatePlaylistSong(playlist: playlist, listOfPlaylist: &playlists)
        cacher.saveToCache(playlists: playlists)
        
        XCTAssertEqual(cacher.loadFromCache().first(where: {$0.name == "Testing"})?.songList.count, initialCount + 1)
        
    }
    
    // Testing the playlist existence checker
    func testPlaylistExist() throws {
        let cacher = PlaylistsViewModel()
        
        XCTAssertTrue(cacher.checkPlaylistExist(name: "Testing"))
    }


}
