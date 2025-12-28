//
//  FavoritesManager.swift
//  RBookApp
//
//  Created by Aisha Hudasi on 03/07/1447 AH.
//

import Foundation
import Combine

@MainActor
final class FavoritesManager: ObservableObject {

    @Published private(set) var favoriteBooks: [Book] = []

    func isFavorite(_ book: Book) -> Bool {
        favoriteBooks.contains(where: { $0.id == book.id })
    }

    func toggle(_ book: Book) {
        if let index = favoriteBooks.firstIndex(where: { $0.id == book.id }) {
            favoriteBooks.remove(at: index)
        } else {
            favoriteBooks.append(book)
        }
    }
}
