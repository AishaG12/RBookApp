//
//  MainTabView.swift
//  RBookApp
//
//  Created by Aisha Hudasi on 25/06/1447 AH.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var favorites: FavoritesManager
    @EnvironmentObject var stats: ReadingStatsManager


   
    private var allBooks: [Book] {
        featuredBooks + homeSections.flatMap { $0.books }
    }

    var body: some View {
        TabView {

            NavigationStack {
                HomeView()
            }
            .tabItem { Image(systemName: "house.fill"); Text("Home") }

            NavigationStack {
                ExploreView()
            }
            .tabItem { Image(systemName: "magnifyingglass"); Text("Explore") }

            NavigationStack {
                FavoritesView(allBooks: allBooks)   
            }
            .tabItem { Image(systemName: "heart.fill"); Text("Favorites") }
        }
       
        .tint(Color("BrandBlue"))
    }
}
#Preview {
    MainTabView()
        .environmentObject(FavoritesManager())
        .environmentObject(ReadingStatsManager())
}
