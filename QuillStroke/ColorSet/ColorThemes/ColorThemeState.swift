//
//  ColorThemeState.swift
//  QuillStroke
//
//  Created by Saverio Negro on 9/27/26.
//

import SwiftUI

protocol ColorThemeState {
    var accent: Color { get }
    var secondary: Color { get }
    var background: Color { get }
    var text: Color { get }
}

