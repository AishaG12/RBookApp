//
//  CategoriesPillRow.swift
//  RBook
//
//  Created by Aisha Hudasi on 03/07/1447 AH.
//

import SwiftUI
struct BookCategory: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let icon: String
}

let bookCategories: [BookCategory] = [
    BookCategory(title: "Education", icon: "graduationcap.fill"),
    BookCategory(title: "Cultural", icon: "globe.europe.africa.fill"),
    BookCategory(title: "Business", icon: "briefcase.fill"),
    BookCategory(title: "Arabic", icon: "text.book.closed"),
    BookCategory(title: "Kids", icon: "teddybear.fill")
]

struct CategoriesPillRow: View {
    @Binding var selectedCategory: String

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(bookCategories) { category in
                    Button {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            selectedCategory = category.title
                        }
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: category.icon)
                                .font(.system(size: 14, weight: .semibold))
                            Text(category.title)
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(
                            Capsule().fill(
                                selectedCategory == category.title
                                ? Color("BrandBlue")
                                : Color(.secondarySystemBackground)
                            )
                        )
                        .foregroundStyle(
                            selectedCategory == category.title ? .white : .primary
                        )
                    }
                }
            }
            .padding(.horizontal, 20)
        }
    }
}
