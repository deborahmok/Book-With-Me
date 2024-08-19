//
//  BookingModel.swift
//  StudyWithMe
//
//  Created by Deborah Mok on 4/10/24.
//

import Foundation

// Protocol that checks to make sure you are naming your functions like intended
// Failure to follow this protocol will result in a 0
protocol BookingModel {
    // Returns the number of booking in your book array
    var numberOfBooking: Int { get }

    // Returns the current flashcard indicated by your currentIndex
    var currentBooking: Book? { get }

        // Returns flashcards that has been marked as favorited
    var favoriteBooks: [Book] { get }
    
    // Initializes a new booking at end of your booking array
    func append(book: Book)

    // Initializes a booking at specific index of your flashcards array
    func insert(book: Book, at index: Int)
    
    // Returns a flashcard at a given index
    func book(at index: Int) -> Book?

    // Removes a booking at a specific index
    func removeBooking(at index: Int)

    // Returns a booking for a given book type
    func getIndex(for book: Book) -> Int?

}
