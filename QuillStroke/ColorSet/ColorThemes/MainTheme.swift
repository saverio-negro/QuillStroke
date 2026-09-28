//
//  MainTheme.swift
//  QuillStroke
//
//  Created by Saverio Negro on 9/27/26.
//

import SwiftUI

struct MainTheme: ColorThemeState {
    var colorSet: ColorSet
    
    func applyTheme() {
        colorSet.accent = Color(red: 0.165, green: 0.514, blue: 0.373)
        colorSet.secondary = Color(red: 0.071, green: 0.329, blue: 0.310)
        colorSet.background = Color(red: 0.035, green: 0.137, blue: 0.157)
        colorSet.text = Color(red: 0.545, green: 0.733, blue: 0.573)
    }
}

