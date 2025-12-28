//
//  HomeView.swift
//  RBookApp
//
//  Created by Aisha Hudasi on 23/06/1447 AH.
//
import SwiftUI

struct HomeView: View {

    @State private var selectedCategory: String = "Education"
    @StateObject private var vm = HomeViewModel()
    @EnvironmentObject var stats: ReadingStatsManager

    private var filteredBooks: [Book] {
        vm.books
    }

    var body: some View {
        ZStack {

            Color(.systemBackground)
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {

                    // MARK: - Header
                    HStack {
                        Image("RbookIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)

                        Spacer()

                        HStack(spacing: 10) {
                            Button(action: { }) {
                                Image(systemName: "bell")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(Color("BrandBlue"))
                                    .frame(width: 40, height: 40)
                                    .background(Color(.secondarySystemBackground).opacity(0.9))
                                    .clipShape(Circle())
                            }
                        }
                    }
                    .padding(.top, 14)

                    // MARK: - Welcome
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Welcome 👋")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundStyle(.primary)

                        Text("What would you like to read today?")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.secondary)
                    }

                    // MARK: - Picked for you (FULL WIDTH)
                  
                    PickedForYouCarousel()
                        .frame(height: 330)
                        .padding(.vertical, 6)

                    // MARK: - Reading Goals (UNDER Picked)
                    ReadingGoalsCard()
                        .padding(.top, 6)

                    // MARK: - Categories pills
                    CategoriesPillRow(selectedCategory: $selectedCategory)
                        .padding(.top, 4)

                    // MARK: - Books list for selected category
                    VStack(alignment: .leading, spacing: 10) {
                        Text("\(selectedCategory) Books")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.primary)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 14) {

                                if vm.isLoading {
                                    ForEach(0..<4, id: \.self) { _ in
                                        RoundedRectangle(cornerRadius: 14)
                                            .fill(Color(.secondarySystemBackground))
                                            .frame(width: 120, height: 200)
                                            .overlay { ProgressView().scaleEffect(0.9) }
                                    }

                                } else if let msg = vm.errorMessage {
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text(msg)
                                            .foregroundStyle(.secondary)

                                        Button("Retry") {
                                            vm.load(category: selectedCategory)
                                        }
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(Color("BrandBlue"))
                                    }

                                } else {
                                    ForEach(filteredBooks) { book in
                                        NavigationLink {
                                            BookDetailsView(book: book)
                                        } label: {
                                            BookCard(book: book)
                                                .contentShape(Rectangle())
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                            }
                            .padding(.vertical, 2) 
                        }
                    }
                    .padding(.top, 6)

                    Spacer(minLength: 24)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 90)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if vm.books.isEmpty {
                vm.load(category: selectedCategory)
            }
        }
        .onChange(of: selectedCategory) { _, newValue in
            vm.load(category: newValue)
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(FavoritesManager())
        .environmentObject(ReadingStatsManager())
}
