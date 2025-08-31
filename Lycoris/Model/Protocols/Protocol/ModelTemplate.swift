//
//  ModelTemplate.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 23/8/2025.
//

/**
    A protocol used for both LrcGroup (Playlist) and LrcRecord (Song Lyric) model.
    Contains a `showID()` function that is mainly used for testing and debugging
*/

import Foundation

protocol ModelTemplate {
    associatedtype IDType
    associatedtype NameType
    
    //The funtionn for this protocol is mainly to perform debugging during the app/observing the process of the app
    func showID() -> IDType
    
    func showName() -> NameType
}
