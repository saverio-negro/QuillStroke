//
//  BookService.swift
//  QuillStroke
//
//  Created by Saverio Negro on 9/27/26.
//

import SwiftUI

protocol BookService {
    func getBooks(searchText: String, page: Int, limit: Int) async throws -> [Book]
    func createBook(_ book: BookCreate) async throws -> Book
    func updateBook(_ book: BookUpdate) async throws -> Book
    func deleteBook(id: Int) async throws
}

