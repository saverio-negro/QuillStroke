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
    var accent: Color? = nil
    var secondary: Color? = nil
    var background: Color? = nil
    var text: Color? = nil
    
    init() {
        self.themeState = MainTheme(colorSet: self)
    }
    
    func applyTheme() {
        self.themeState?.applyTheme()
    }
    
    func setThemeState(themeState: ColorThemeState) {
        self.themeState = themeState
    }
}

