//
//  ColorExtension.swift
//  Lycoris
//
//  Created by Dương Anh Trần on 25/8/2025.
//

import Foundation
import SwiftUICore

/**
    - An extension for SwiftUI's `Color` attribute
    - This extension allows hexidecimal color code to be used in the program
 **/

extension Color {
    init(hex: Int) {
    self.init(
      .sRGB,
      red: Double((hex >> 16) & 0xff) / 255,
      green: Double((hex >> 8) & 0xff) / 255,
      blue: Double((hex >> 0) & 0xff) / 255,
      opacity: 1
    )
  }
}
