//
//  ColorSet.swift
//  QuillStroke
//
//  Created by Saverio Negro on 9/27/26.
//

import SwiftUI

// Use State Pattern to change behavior (color properties) of `ColorSet` depending on its current state (`ColorThemeState`)
class ColorSet {
    var themeState: ColorThemeState? = nil
    var accent: Color = .clear
    var secondary: Color = .clear
    var background: Color = .clear
    var text: Color = .clear
    
    init() {
        // Set `MainTheme` as the initial state
        self.themeState = MainTheme(colorSet: self)
        applyTheme()
    }
    
    func applyTheme() {
        self.themeState?.applyTheme()
    }
    
    func setThemeState(themeState: ColorThemeState) {
        self.themeState = themeState
        applyTheme()
    }
}

