//
//  HomeViewModel.swift
//  RBookApp
//
//  Created by Aisha Hudasi on 26/06/1447 AH.
//

import Foundation
import Combine



@MainActor
final class HomeViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil

    func load(category: String) {
        isLoading = true
        errorMessage = nil

        if let section = homeSections.first(where: { $0.title == category }) {
            books = section.books
        } else {
            books = featuredBooks
        }

        isLoading = false
    }
}

