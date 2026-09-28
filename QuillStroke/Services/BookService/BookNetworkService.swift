//
//  BookNetworkService.swift
//  QuillStroke
//
//  Created by Saverio Negro on 9/28/26.
//

import SwiftUI

class BookNetworkService: BookService {
    private let baseURL = "http://127.0.0.1:8000/books"
    
    func getBooks(searchText: String?, page: Int, limit: Int) async throws -> [Book] {
        var components = URLComponents(string: baseURL)!
        
        var queryItems = [
            // `skip` represents the number of items to bypass before
            // starting to collect items
            URLQueryItem(name: "skip", value: String((page - 1) * limit)),
            URLQueryItem(name: "limit", value: String(limit))
        ]
        
        if let searchText = searchText, !searchText.isEmpty {
            queryItems.append(URLQueryItem(name: "search_text", value: searchText))
        }
        
        components.queryItems = queryItems
        
        let (data, response) = try await URLSession.shared.data(from: components.url!)
        
        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299
        else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode([Book].self, from: data)
    }
    
    func createBook(_ book: BookCreate) async throws -> Book {
        // Create a URLRequest object to configure the request
        var request = URLRequest(url: URL(string: baseURL)!)
        
        // Set the HTTP request method to be a POST method
        request.httpMethod = "POST"
        
        // Configure the "Content-Type" header field to let the server know
        // the request body content is of type JSON
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Set the body of the request to the JSON-encoded `BookCreate` object
        request.httpBody = try JSONEncoder().encode(book)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299
        else {
            throw URLError(.badServerResponse)
        }
        
        let newBook = try JSONDecoder().decode(Book.self, from: data)
        return newBook
    }
    
    func updateBook(id: Int, _ book: BookUpdate) async throws -> Book {
        // Create a URLRequest object to configure the request
        var request = URLRequest(url: URL(string: "\(baseURL)/\(id)")!)
        
        // Set the HTTP request method to be a PUT method
        request.httpMethod = "PUT"
        
        // Configure the "Content-Type" header field to let the server know
        // the request body content is of type JSON
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Set the body of the request to the JSON-encoded `BookUpdate` object
        request.httpBody = try JSONEncoder().encode(book)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299
        else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(Book.self, from: data)
    }
    
    func deleteBook(id: Int) async throws {
        // Create a URLRequest object to configure the request
        var request = URLRequest(url: URL(string: "\(baseURL)/\(id)")!)
        
        // Set the HTTP request method to be a DELETE method
        request.httpMethod = "DELETE"
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299
        else {
            throw URLError(.badServerResponse)
        }
    }
}

