//
//  FeaturedBookCard.swift
//  RBook
//
//  Created by Aisha Hudasi on 02/07/1447 AH.
//

//
//  FeaturedBookCard.swift
//  RBook
//
//  Created by Aisha Hudasi on 02/07/1447 AH.
//

import SwiftUI

struct FeaturedBookCard: View {
    let book: Book

    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            AsyncImage(url: book.coverURL) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                } else if phase.error != nil {
                    // Failure
                    ZStack {
                        Color(.secondarySystemBackground)
                        Image(systemName: "book.closed")
                            .font(.system(size: 36))
                            .foregroundColor(Color("BrandBlue"))
                    }
                } else {
                    // Loading
                    ZStack {
                        Color(.secondarySystemBackground)
                        ProgressView()
                    }
                }
            }
            .frame(width: 170, height: 250)
            .clipped()
            .cornerRadius(16)

            Text(book.title)
                .padding(.leading, 10)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(.primary)
                .lineLimit(2)

            StarRatingView(rating: book.rating)

            Text(book.description)
                .font(.system(size: 12))
                .foregroundStyle(.secondary)
                .lineLimit(2)
                .padding(.leading, 10)
        }
        .frame(width: 190, alignment: .leading)
    }
}
