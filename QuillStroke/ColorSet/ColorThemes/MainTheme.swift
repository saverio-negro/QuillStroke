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
        colorSet.accent = Color(red: 42, green: 131, blue: 95)
        colorSet.secondary = Color(red: 18, green: 84, blue: 79)
        colorSet.background = Color(red: 9, green: 35, blue: 40)
        colorSet.text = Color(red: 139, green: 187, blue: 146)
    }
}

