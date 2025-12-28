//
//  PickedForYouCarousel.swift
//  RBook
//
//  Created by Aisha Hudasi on 02/07/1447 AH.
//

import SwiftUI
import Combine

struct PickedForYouCarousel: View {
    @State private var pageIndex: Int = 0
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    private var books: [Book] {
        Array(featuredBooks.prefix(6))
    }

    private var pagesCount: Int {
        (books.count + 1) / 2            
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Picked for you")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color("BrandBlue"))
                .padding(.bottom, -20)


            TabView(selection: $pageIndex) {

                ForEach(0..<pagesCount, id: \.self) { page in
                    let first = page * 2
                    let second = first + 1

                    HStack(spacing: 1) {

                       
                        NavigationLink {
                            BookDetailsView(book: books[first])
                        } label: {
                            FeaturedBookCard(book: books[first])
                        }
                        .buttonStyle(.plain)

                        
                        if second < books.count {
                            NavigationLink {
                                BookDetailsView(book: books[second])
                            } label: {
                                FeaturedBookCard(book: books[second])
                            }
                            .buttonStyle(.plain)
                        } else {
                            Spacer() 
                        }
                    }
                    .padding(.horizontal, 20)
                    .tag(page)
                }
            }
            
            .frame(height: 360)
            .tabViewStyle(.page(indexDisplayMode: .automatic))
            .onReceive(timer) { _ in
                guard pagesCount > 0 else { return }
                withAnimation(.easeInOut) {
                    pageIndex = (pageIndex + 1) % pagesCount
                }
            }
        }
    }
}
#Preview {
    MainTabView()
        .environmentObject(FavoritesManager())
        .environmentObject(ReadingStatsManager())
}
