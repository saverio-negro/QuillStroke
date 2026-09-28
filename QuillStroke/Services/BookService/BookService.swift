//
//  BookService.swift
//  QuillStroke
//
//  Created by Saverio Negro on 9/27/26.
//

import SwiftUI

// Using a `BookService` protocol allows us to later inject a `MockBookService`
// for SwiftUI Previews and Unit Testing.
protocol BookService {
    func getBooks(searchText: String?, page: Int, limit: Int) async throws -> [Book]
    func createBook(_ book: BookCreate) async throws -> Book
    func updateBook(id: Int, _ book: BookUpdate) async throws -> Book
    func deleteBook(id: Int) async throws
}

