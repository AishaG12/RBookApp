//
//  ContentView.swift
//  RBookApp
//
//  Created by Aisha Hudasi on 23/06/1447 AH.
//
import SwiftUI

struct SplashView: View {

    @State private var isActive = false
    @State private var scale: CGFloat = 0.8
    @State private var opacity: Double = 0.0

    var body: some View {
        if isActive {
            MainTabView()
        } else {
            ZStack {
                Color(.systemBackground)
                    .ignoresSafeArea()

                Image("RbookLogoSplash")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 180)
                    .scaleEffect(scale)
                    .opacity(opacity)
            }
            .onAppear {
                withAnimation(.easeOut(duration: 1.2)) {
                    scale = 1.0
                    opacity = 1.0
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation { isActive = true }
                }
            }
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(FavoritesManager())
        .environmentObject(ReadingStatsManager())
}

















































