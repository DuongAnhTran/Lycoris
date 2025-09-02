//
//  ModelSavingTemplate.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 2/9/2025.
//



import Foundation

protocol ModelSavingTemplate {
    associatedtype Input
    associatedtype Output
    
    func filter(input: Input, searchText: String) -> Output
    
}
