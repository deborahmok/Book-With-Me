//
//  Photo.swift
//  StudyWithMe
//
//  Created by Deborah Mok on 4/24/24.
//

import Foundation
import SwiftUI
import UIKit

struct Photo: Identifiable, Codable {
    let id: UUID
    let image: Data
    let createdAt: Date
    
    public init(image: UIImage, createdDate: Date) {
        //converting image for UIImage
        self.image = image.pngData()!
        createdAt = createdDate
        id = UUID()
    }
}

extension Photo: Equatable {
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id
    }
}

