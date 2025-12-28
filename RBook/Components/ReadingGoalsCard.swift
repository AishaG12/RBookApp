//
//  ReadingGoalsCard.swift
//  RBookApp
//
//  Created by Aisha Hudasi on 27/06/1447 AH.
//
import SwiftUI

struct ReadingGoalsCard: View {
    @EnvironmentObject var stats: ReadingStatsManager
    
    private let goal: Double = 12
    
    private var progress: Double {
        min(Double(stats.booksCountThisYear) / goal, 1.0)
    }
    
    
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            
            Text("Reading Goals")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(Color("BrandBlue"))
            
            Text("Books you started or added to favorites this year.")
                .font(.system(size: 13))
                .foregroundStyle(.secondary)
            
            HStack {
                Spacer()
                
                ZStack {
                    
                    
                    Circle()
                        .trim(from: 0, to: 0.5 * progress)
                        .stroke(
                            blueGradient,
                            style: StrokeStyle(lineWidth: 15, lineCap: .round)
                        )
                        .rotationEffect(.degrees(180))
                        .padding(8)
                        .drawingGroup()
                    
                    
                    
                    Circle()
                        .trim(from: 0, to: 0.5)
                        .stroke(
                            Color.primary.opacity(0.18),
                            style: StrokeStyle(lineWidth: 15, lineCap: .round)
                        )
                        .rotationEffect(.degrees(180))
                        .padding(8)
                    
                    
                    VStack(spacing: 6) {
                        Text("Books")
                            .font(.system(size: 12))
                            .foregroundStyle(.secondary)
                        
                        Text("\(stats.booksCountThisYear)")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundStyle(Color("BrandBlue"))
                        
                        Divider()
                            .frame(width: 70)
                            .opacity(0.35)
                        
                        HStack(spacing: 12) {
                            Text("Favorites \(stats.favoriteIDs.count)")
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundStyle(.primary)
                            
                            Text("Read \(stats.startedIDs.count)")
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundStyle(.primary)
                            Button {
                                stats.resetNow()
                            } label: {
                                Image(systemName: "arrow.counterclockwise")
                                    .font(.system(size: 10, weight: .semibold))
                                    .foregroundStyle(Color("BrandBlue"))
                                    .padding(4)
                                    .background(
                                        Circle()
                                            .fill(Color("BrandBlue").opacity(0.15))
                                    )
                            }
                            .buttonStyle(.plain)
                        }
                        .foregroundStyle(.primary)
                    }
                }
                .frame(width: 170, height: 170)
                Spacer()
            }
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.thickMaterial)
        )
    }
}

private var blueGradient: LinearGradient {
    LinearGradient(
        colors: [
            Color(red: 0.00, green: 0.35, blue: 0.70),
            Color(red: 0.00, green: 0.50, blue: 0.80),
            Color(red: 0.00, green: 0.65, blue: 0.90),
            Color(red: 0.10, green: 0.78, blue: 0.96),
            Color(red: 0.35, green: 0.88, blue: 0.99),
            Color(red: 0.60, green: 0.94, blue: 1.00)
        ],
        startPoint: .leading,
        endPoint: .trailing
    )
}
#Preview {
    ZStack {
        Color.black
        ReadingGoalsCard()
            .environmentObject(ReadingStatsManager())
    }
}
