//
//  BookCard.swift
//  RBook
//
//  Created by Aisha Hudasi on 03/07/1447 AH.
//

import SwiftUI
struct BookCard: View {
let book: Book

var body: some View {
    VStack(alignment: .leading, spacing: 6) {

        
        ZStack {
            Color.gray.opacity(0.12)
            AsyncImage(url: book.coverURL) { phase in
                if let img = phase.image {
                    img
                       
                       // .scaledToFit()
                        .padding(10)
                } else {
                    Image(systemName: "book.closed")
                        .font(.system(size: 26))
                        .foregroundColor(Color("BrandBlue"))
                }
            }
        }
        .frame(width: 130, height: 185)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

       
        Text(book.title)
            .font(.system(size: 11, weight: .semibold))
            .lineLimit(2)
            .frame(height: 28, alignment: .top)

       
        StarRatingView(rating: book.rating)
           

        
        Text(book.description)
            .font(.system(size: 10))
            .foregroundStyle(.secondary)
            .lineLimit(2)
            .frame(height: 28, alignment: .top)

   
              }
             
              .frame(width: 130, height: 300, alignment: .top)
              
              .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
          }
      }
