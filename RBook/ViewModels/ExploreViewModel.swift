//
//  ExploreViewModel.swift
//  RBookApp
//
//  Created by Aisha Hudasi on 26/06/1447 AH.
//
import Foundation
import Combine


@MainActor
final class ExploreViewModel: ObservableObject {

    @Published var query: String = ""
    @Published var results: [Book] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let service = BookService()

    func search() {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !q.isEmpty else {
            print("Search blocked: empty query")
            return
        }

        isLoading = true
        errorMessage = nil
        print("Explore search started. Query:", q)

        Task {
            do {
          
                let books = try await service.searchBooks(query: q)
                self.results = books
                self.isLoading = false
                print("Explore search success. Count:", books.count)
            } catch {
                self.isLoading = false
                self.errorMessage = (error as? LocalizedError)?.errorDescription ?? "Search failed. Try again."
                print("Explore search failed:", error.localizedDescription)
            }
        }
    }

    func clear() {
        query = ""
        results = []
        errorMessage = nil
        isLoading = false
        print("Explore cleared")
    }
}
