//
//  ModelSavingTemplate.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 2/9/2025.
//


// A protocol/template for view model that responsible for saving playlists and songs
import Foundation

protocol ModelSavingTemplate {
    associatedtype Input
    associatedtype Output
    
    func filter(input: Input, searchText: String) -> Output
    
}
