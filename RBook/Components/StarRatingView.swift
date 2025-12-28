//
//  StarRatingView.swift
//  RBook
//
//  Created by Aisha Hudasi on 02/07/1447 AH.
//
import SwiftUI

struct StarRatingView: View {
    let rating: Double

    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...5, id: \.self) { i in
                Image(systemName: rating >= Double(i) ? "star.fill" : "star")
                    .font(.system(size: 11))
                    .foregroundColor(.orange)
            }

            Text(String(format: "%.1f", rating))
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.secondary)
        }
        .padding(.leading, 10)
    }
}
