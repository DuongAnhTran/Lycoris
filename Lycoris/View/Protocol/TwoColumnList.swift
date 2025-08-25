//
//  TwoColumnList.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 25/8/2025.
//

import Foundation
import SwiftUI

protocol TwoColumnList: View {
    var Text1: String { get }
    var Text2: String { get }
    var font: Font? { get }
}

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
