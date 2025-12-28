//
//  BookRow.swift
//  RBook
//
//  Created by Aisha Hudasi on 02/07/1447 AH.
//


import SwiftUI

struct BookRow: View {
    let book: Book

    var body: some View {
        HStack(spacing: 12) {

            AsyncImage(url: book.coverURL) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                } else if phase.error != nil {
                    
                    ZStack {
                        Color.gray.opacity(0.12)
                        Image(systemName: "book.closed")
                            .foregroundColor(.gray)
                    }
                } else {
                   
                    ZStack {
                        Color.gray.opacity(0.10)
                        ProgressView()
                    }
                }
            }
            .frame(width: 55, height: 80)
            .clipped()
            .cornerRadius(10)

            VStack(alignment: .leading, spacing: 6) {
                Text(book.title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black.opacity(0.85))
                    .lineLimit(2)

                Text(book.author)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }

            
            Spacer()
        }
        .padding(.vertical, 6)
    }
}
