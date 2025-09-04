//
//  ViewModelemplate.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 2/9/2025.
//


// A protocol/template for view model that responsible for saving playlists and songs
import Foundation

protocol ViewModelTemplate {
    
    // Declare 2 associated types for Input and Output of the filter function
    associatedtype Input
    associatedtype Output
    
    // The filter function helps sort out, and find the needed items in a list (will be used for cached song finding and user's playlist finding)
    func filter(input: Input, searchText: String) -> Output
    
}
