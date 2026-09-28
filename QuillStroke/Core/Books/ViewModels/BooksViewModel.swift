//
//  BooksViewModel.swift
//  QuillStroke
//
//  Created by Saverio Negro on 9/28/26.
//

import SwiftUI

// Manage the state of the `BooksView`. Handle the presentation/business logic,
// the rollbacks, the pagination, as well as coordinate with the service.
@MainActor
class BooksViewModel: ObservableObject {
    
    @Published var books: [Book] = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    @Published var errorMessage: String?
    
    // The book service dependency
    private let service: BookService
    
    // Pagination tracking
    private var currentPage = 1
    private var hasMorePages = true
    private let limit = 20
    
    init(service: BookService) {
        self.service = service
        Task { await fetchBooks(reset: true) }
    }
    
    func performSearch() async {
        await fetchBooks(reset: true)
    }
    
    func loadMoreBooks() async {
        guard hasMorePages && !isLoading else { return }
        currentPage += 1
        await fetchBooks(reset: false)
    }
    
    func fetchBooks(reset: Bool) async {
        if reset {
            currentPage = 1
            hasMorePages = true
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedBooks = try await self.service.getBooks(
                searchText: searchText.isEmpty ? nil : searchText,
                page: currentPage,
                limit: limit
            )
            
            if reset {
                books = fetchedBooks // Overwrite on search or refresh
            } else {
                books.append(contentsOf: fetchedBooks) // Append on pagination
            }
            
            hasMorePages = fetchedBooks.count == limit
            
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func createBook(title: String, author: String, yearPublished: Int?) async {
        let newBookData = BookCreate(title: title, author: author, yearPublished: yearPublished)
        
        do {
            // Pessimistic Update Strategy: Wait for the server to assign the ID
            let createdBook = try await self.service.createBook(newBookData)
            books.insert(createdBook, at: 0)
        } catch {
            errorMessage = "Failed to create book."
        }
    }
    
    func deleteBook(_ book: Book) async {
        // Optimistic Update Strategy: Cache current state and remove instantly
        let backup = books
        books.removeAll(where: { $0.id == book.id })
        
        do {
            try await self.service.deleteBook(id: book.id)
        } catch {
            // Rollback on failure
            books = backup
            errorMessage = "Failed to delete \(book.title)."
        }
    }
    
    func updateBook(id: Int, title: String?, author: String?, yearPublished: Int?) async {
        // Optimistic Update Strategy: Cache current state and update instantly
        let backup = books
        let updatedBookData = BookUpdate(title: title, author: author, yearPublished: yearPublished)
        let bookIndex = books.firstIndex(where: { $0.id == id })!
        let oldBook = books[bookIndex]
        let newBook = Book(
            id: id,
            title: title ?? oldBook.title,
            author: author ?? oldBook.author,
            yearPublished: yearPublished ?? oldBook.yearPublished
        )
        books[bookIndex] = newBook
        
        do {
            _ = try await self.service.updateBook(id: id, updatedBookData)
        } catch {
            // Rollback on failure
            books = backup
            errorMessage = "Failed to update \(oldBook.title)"
        }
    }
}
