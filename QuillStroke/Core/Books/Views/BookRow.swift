//
//  BookRow.swift
//  QuillStroke
//
//  Created by Saverio Negro on 9/28/26.
//

import SwiftUI

struct BookRow: View {
    
    let book: Book
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(book.title)
                .font(.headline)
                .foregroundStyle(.colorSet.text)
            Text(book.author)
                .font(.subheadline)
                .foregroundStyle(.colorSet.text)
        }
    }
}
