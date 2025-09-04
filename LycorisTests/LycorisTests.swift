//
//  LycorisTests.swift
//  LycorisTests
//
//  Created by Dương Anh Trần on 23/8/2025.
//

// This is the unit test file for the app. This file will have some test cases that will examine some of the main processes in the app, ensuring that the application is functioning properly
// These processes include adding song/playlist and deleting song/playlist and check if a playlist is existing

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
        
        // Create a new song object for testing
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
    

    
    // A test for playlist deleting process.
    func testPlaylistDelete() throws {
        let cacher = PlaylistsViewModel()
        let playlists = cacher.loadFromCache()
        
        // Adding a new playlist for testing
        cacher.addPlaylist(name: "Testing")
        let newPlaylistID = cacher.loadFromCache().last?.id
        
        let initialPlaylistCount = playlists.count
        
        // Find the playlist and perform deletion on it and check if the playlist is gone + the amount of playlists decreases
        if let index = playlists.firstIndex(where: {$0.id == newPlaylistID}) {
            let indexSet = IndexSet(integer: index)
            cacher.deletePlaylist(at: indexSet)
            XCTAssertEqual(cacher.loadFromCache().count, initialPlaylistCount - 1)
            XCTAssertFalse(cacher.loadFromCache().contains(where: {$0.id == newPlaylistID}))
        }
    }
    
    
    // A test for deleting song process (This also have the same reasoning for with playlist deleting process)
    // The test doesn't check if the playlist contains the ID of the song because sometimes a playlist can have the same song with the same ID.
    func testSongDelete() throws {
        let cacher = PlaylistsViewModel()
        let lyricVM = LyricsViewModel()
        
        // Add a new playlist for testing and get list of playlist from cache
        cacher.addPlaylist(name: "Testing")
        var playlists = cacher.loadFromCache()
        let playlistID = playlists.last?.id
        
        // Create a testing LrcRecord object and add it in the playlist
        var playlist = playlists.first(where: {$0.name == "Testing"})!
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
        let initialSongCount = playlist.songList.count
        
        
        // Find the one with the name "Testing" and perform removal. After that check if the amount of song decreases
        var afterAddPlaylists = cacher.loadFromCache()
        
        if var afterAddPlaylist = afterAddPlaylists.first(where: {$0.id == playlistID}) {
            if let index = afterAddPlaylist.songList.firstIndex(where: {$0.id == 0}) {
                lyricVM.removeSongfromPlaylist(index: index, playlist: &afterAddPlaylist, listOfPlaylists: &afterAddPlaylists)
                XCTAssertEqual(cacher.loadFromCache().first(where: {$0.id == playlistID})?.songList.count, initialSongCount - 1)
            }
        }
    }

}
