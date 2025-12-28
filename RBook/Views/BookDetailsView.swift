//
//  BookDetailsView.swift
//  RBookApp
//
//  Created by Aisha Hudasi on 25/06/1447 AH.
//
import SwiftUI

struct BookDetailsView: View {
    let book: Book

    @EnvironmentObject var favorites: FavoritesManager
    @EnvironmentObject var stats: ReadingStatsManager

    @State private var startedAt: Date? = nil
    @State private var showReader = false
    @State private var showNoPreview = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {

                AsyncImage(url: book.coverURL) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                    } else if phase.error != nil {
                        ZStack {
                            Color.gray.opacity(0.12)
                            Image(systemName: "book.closed")
                                .font(.system(size: 46))
          
                                .foregroundStyle(Color("BrandBlue"))
                               
                        }
                    } else {
                        ZStack {
                            Color.gray.opacity(0.10)
                            ProgressView()
                        }
                    }
                }
                .frame(height: 440)  
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))


                Text(book.title)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(.primary)

                Text(book.author)
                    .font(.system(size: 15))
                    .foregroundStyle(.secondary)

                StarRatingView(rating: book.rating)

                HStack(spacing: 12) {

                    Button {
                        favorites.toggle(book)
                        stats.toggleFavorite(book)
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: favorites.isFavorite(book) ? "heart.fill" : "heart")
                            Text(favorites.isFavorite(book) ? "Remove Favorite" : "Add Favorite")
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color("BrandBlue"))
                        .cornerRadius(14)
                    }

                    Button {
                        if book.readerURL != nil {
                            stats.markStarted(book)
                            startedAt = Date()
                            showReader = true
                        } else {
                            showNoPreview = true
                        }
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "book.fill")
                            Text("Read")
                        }
                        .foregroundColor(book.readerURL != nil ? Color("BrandBlue") : .gray)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(book.readerURL != nil ? Color("BrandBlue").opacity(0.12) : Color.gray.opacity(0.12))
                        .cornerRadius(14)
                    }
                }

                Text("About")
                    .font(.system(size: 16, weight: .bold))
                    .padding(.top, 6)
                    .foregroundStyle(.primary)

                Text(book.description)
                    .foregroundStyle(.secondary)
            }
            .padding(20)
        }
        .navigationBarTitleDisplayMode(.inline)

        .sheet(isPresented: $showReader, onDismiss: {
            if let start = startedAt {
                let minutes = max(Int(Date().timeIntervalSince(start) / 60), 1)
                stats.addMinutes(minutes, for: book)
                startedAt = nil
            }
        }) {
            if let url = book.readerURL {
                BookReaderView(url: url)
            }
        }

        .alert("No preview available", isPresented: $showNoPreview) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("This book doesn't have an online reader link.")
        }
    }
}


#Preview {
    MainTabView()
        .environmentObject(FavoritesManager())
        .environmentObject(ReadingStatsManager())
}
