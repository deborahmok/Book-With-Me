//
//  Book.swift
//  StudyWithMe
//
//  Created by Deborah Mok on 4/10/24.
//

import Foundation

struct Book: Codable, Hashable, Identifiable{
    let id : String
    let name: String
    let time: Date
    let location: String
}
