//
//  Book.swift
//  QuillStroke
//
//  Created by Saverio Negro on 9/27/26.
//

import SwiftUI

// Book Model
struct Book: Codable, Identifiable {
    let id: Int
    let title: String
    let author: String
    let yearPublished: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case author = "author"
        case yearPublished = "year_published"
    }
}

// POST Create Book Schema
struct BookCreate: Codable {
    let title: String
    let author: String
    let yearPublished: Int?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case author = "author"
        case yearPublished = "year_published"
    }
}

// PUT Update Book Schema
struct BookUpdate: Codable {
    let title: String?
    let author: String?
    let yearPublished: Int?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case author = "author"
        case yearPublished = "year_published"
    }
}

