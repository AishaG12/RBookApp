//
//  Book.swift
//  RBook
//
//  Created by Aisha Hudasi on 02/07/1447 AH.
//
import Foundation

struct Book: Identifiable, Hashable {
    let id: String
    let title: String
    let author: String
    let isbn: String
    let rating: Double
    let description: String
    let coverID: Int?

   
    let coverLink: String?
    let readerLink: String?

    init(
        id: String = UUID().uuidString,
        title: String,
        author: String,
        isbn: String = "",
        rating: Double,
        description: String,
        coverID: Int? = nil,
        coverLink: String? = nil,
        readerLink: String? = nil
    ) {
        self.id = id
        self.title = title
        self.author = author
        self.isbn = isbn
        self.rating = rating
        self.description = description
        self.coverID = coverID
        self.coverLink = coverLink
        self.readerLink = readerLink
    }

    var coverURL: URL? {
        
        if let coverLink, let url = URL(string: coverLink) { return url }

        
        if let coverID {
            return URL(string: "https://covers.openlibrary.org/b/id/\(coverID)-M.jpg")
        }

        
        
        guard !isbn.isEmpty else { return nil }
        return URL(string: "https://covers.openlibrary.org/b/isbn/\(isbn)-M.jpg")
    }

    var readerURL: URL? {
        
        if let readerLink, let url = URL(string: readerLink) { return url }

        
        guard !isbn.isEmpty else { return nil }
        return URL(string: "https://books.google.com/books?vid=ISBN\(isbn)&printsec=frontcover&output=embed")
    }
}
