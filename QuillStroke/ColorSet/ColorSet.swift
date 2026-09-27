//
//  ColorSet.swift
//  QuillStroke
//
//  Created by Saverio Negro on 9/27/26.
//

import SwiftUI

struct ColorSet {
    
    var themeState: ColorThemeState
    
    var accent: Color {
        return themeState.accent
    }
    
    var secondary: Color {
        return themeState.secondary
    }
    
    var background: Color {
        return themeState.background
    }
    
    var text: Color {
        return themeState.text
    }
}

