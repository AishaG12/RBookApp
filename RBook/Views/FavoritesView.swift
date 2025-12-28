//
//  FavoritesView.swift
//  RBookApp
//
//  Created by Aisha Hudasi on 25/06/1447 AH.
//
import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favorites: FavoritesManager
    let allBooks: [Book]

    private var favoriteBooks: [Book] {
        allBooks.filter { favorites.isFavorite($0) }

    }

    var body: some View {
        Group {
            if favoriteBooks.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "heart")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                    Text("No favorites yet")
                        .foregroundColor(.gray)
                }
            } else {
                ScrollView {
                    LazyVStack(spacing: 14) {
                        ForEach(favoriteBooks) { book in
                            NavigationLink {
                                BookDetailsView(book: book)
                            } label: {
                                BookRow(book: book)
                                    .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Favorites")
        .navigationBarTitleDisplayMode(.inline)
    }
}
