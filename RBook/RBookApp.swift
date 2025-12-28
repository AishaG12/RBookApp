//
//  RBookApp.swift
//  RBook
//
//  Created by Aisha Hudasi on 27/06/1447 AH.
//

import SwiftUI

@main
struct RBookAppApp: App {

    @StateObject private var favorites = FavoritesManager()
    @StateObject private var stats = ReadingStatsManager()

    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(favorites)
                .environmentObject(stats)
               
        }
    }
}

