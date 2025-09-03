//
//  TwoColumnList.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 25/8/2025.
//

import Foundation
import SwiftUI

/**
    A protocol used to format a list item into 2 columns. Used to show the information
    of a playlist in the `PlaylistView` (showing the name of the playlist and the creation date)
 */

protocol TwoColumnList: View {
    var Text1: String { get }
    var Text2: String { get }
    var font: Font? { get }
}

// An extension of the protocol to do the formating for the view
extension TwoColumnList {
    var body: some View {
        HStack {
            Text(Text1)
                .frame(maxWidth: .infinity)
                .font(font)
            
            Divider()
            
            Text(Text2)
                .frame(maxWidth: .infinity)
                .font(font)
        }
    }
}
