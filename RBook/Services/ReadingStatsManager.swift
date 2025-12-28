//
//  ReadingStatsManager.swift
//  RBookApp
//
//  Created by Aisha Hudasi on 27/06/1447 AH.
//

import Foundation
import Combine

@MainActor
final class ReadingStatsManager: ObservableObject {

    
    private let favoritesKey = "rb_favorite_ids"
    private let startedKey   = "rb_started_ids"
    private let minutesKey   = "rb_minutes_by_id"
    private let yearKey      = "rb_year"

    
    private let dayStartKey  = "rb_day_start"

    @Published private(set) var favoriteIDs: Set<String> = []
    @Published private(set) var startedIDs: Set<String> = []
    @Published private(set) var minutesByID: [String: Int] = [:]

    private(set) var year: Int = Calendar.current.component(.year, from: Date())

    init() {
        load()
        rolloverDailyIfNeeded()
        rolloverYearlyIfNeeded()
    }

    
    // MARK: - Public

    
    var booksCountThisYear: Int {
        favoriteIDs.union(startedIDs).count
    }

    func isFavorite(_ book: Book) -> Bool { favoriteIDs.contains(book.id) }
    func hasStarted(_ book: Book) -> Bool { startedIDs.contains(book.id) }
    func minutesRead(for book: Book) -> Int { minutesByID[book.id] ?? 0 }

    func toggleFavorite(_ book: Book) {
        if favoriteIDs.contains(book.id) {
            favoriteIDs.remove(book.id)
        } else {
            favoriteIDs.insert(book.id)
        }
        save()
    }

    func markStarted(_ book: Book) {
        startedIDs.insert(book.id)
        save()
    }

    func addMinutes(_ minutes: Int, for book: Book) {
        guard minutes > 0 else { return }
        minutesByID[book.id, default: 0] += minutes
        startedIDs.insert(book.id)
        save()
    }

    
    func forceCheckDailyReset() {
        rolloverDailyIfNeeded()
    }

   
    func resetNow() {
        favoriteIDs.removeAll()
        startedIDs.removeAll()
        minutesByID.removeAll()

        let ud = UserDefaults.standard
        ud.set(Calendar.current.startOfDay(for: Date()), forKey: dayStartKey)

        save()
    }

    // MARK: - Reset Daily (12 AM)

    private func rolloverDailyIfNeeded() {
        let ud = UserDefaults.standard

        let todayStart = Calendar.current.startOfDay(for: Date())
        let savedStart = ud.object(forKey: dayStartKey) as? Date

       
        guard let savedStart else {
            ud.set(todayStart, forKey: dayStartKey)
            return
        }

        
        if savedStart < todayStart {
            favoriteIDs.removeAll()
            startedIDs.removeAll()
            minutesByID.removeAll()

            ud.set(todayStart, forKey: dayStartKey)
            save()
        }
    }

    // MARK: - Reset Yearly
    private func rolloverYearlyIfNeeded() {
        let current = Calendar.current.component(.year, from: Date())
        if current != year {
            year = current
            favoriteIDs.removeAll()
            startedIDs.removeAll()
            minutesByID.removeAll()

            let ud = UserDefaults.standard
            ud.set(Calendar.current.startOfDay(for: Date()), forKey: dayStartKey)

            save()
        }
    }

    // MARK: - Storage

    private func load() {
        let ud = UserDefaults.standard

        year = ud.integer(forKey: yearKey)
        if year == 0 { year = Calendar.current.component(.year, from: Date()) }

        if let fav = ud.array(forKey: favoritesKey) as? [String] {
            favoriteIDs = Set(fav)
        }
        if let started = ud.array(forKey: startedKey) as? [String] {
            startedIDs = Set(started)
        }
        if let dict = ud.dictionary(forKey: minutesKey) as? [String: Int] {
            minutesByID = dict
        }

        
        if ud.object(forKey: dayStartKey) == nil {
            ud.set(Calendar.current.startOfDay(for: Date()), forKey: dayStartKey)
        }
    }

    private func save() {
        let ud = UserDefaults.standard
        ud.set(year, forKey: yearKey)
        ud.set(Array(favoriteIDs), forKey: favoritesKey)
        ud.set(Array(startedIDs), forKey: startedKey)
        ud.set(minutesByID, forKey: minutesKey)

       
        if ud.object(forKey: dayStartKey) == nil {
            ud.set(Calendar.current.startOfDay(for: Date()), forKey: dayStartKey)
        }
    }
}

