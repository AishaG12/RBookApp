//
//  BookSection.swift
//  RBook
//
//  Created by Aisha Hudasi on 03/07/1447 AH.
//

import Foundation

struct BookSection: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let books: [Book]
}
