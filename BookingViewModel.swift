//
//  BookingViewModel.swift
//  StudyWithMe
//
//  Created by Deborah Mok on 4/10/24.
//

import Foundation

class BookingViewModel : BookingModel, ObservableObject{
    private var bookingFilePath : URL
    @Published var books: [Book] = []{
        didSet {
            save()
        }
    }
    @Published var currentIndex = 0{
        didSet {
            //not to go out of bounds
            if currentIndex < 0 || currentIndex >= books.count{
                print("Out of bounds")
            }
        }
    }
    
    init() {
        bookingFilePath = FileManager.default.urls(for: .documentDirectory,
                                                      in: .userDomainMask).first!.appendingPathComponent("bookings.json")
        // try to load flashcards
        if let books = load() {
            self.books = books
        }
        
        if (books.isEmpty)
            {
            append(book: Book(id: UUID().uuidString, name: "Connor", time: Date(), location: "School"))
            append(book: Book(id: UUID().uuidString, name: "Ava",time: Date(), location: "Cafe"))
            append(book: Book(id: UUID().uuidString, name: "John",time: Date(), location: "Library"))
            append(book: Book(id: UUID().uuidString, name: "Lisa",time: Date(), location: "House"))
        }
    }
    
    // Attempts to read from disk and decodes from JSON into Swift objects
    private func load() -> [Book]?{
        // Your implementation here
        do {
            let data = try Data(contentsOf: bookingFilePath)
            let books = try JSONDecoder().decode([Book].self, from: data)
            return books
        } catch {
            return nil
        }
    }
    
    // Attemps to encodes Swift objects into JSON and saves to disk
    private func save(){
        // Your implementation here
        do {
            let data = try JSONEncoder().encode(books)
            try data.write(to: bookingFilePath)
        } catch {
            print("Error saving booking: \(error)")
        }
    }
    
    var numberOfBooking: Int {
        return books.count
    }
    
    var currentBooking: Book? {
        if (books.isEmpty){
            return nil;
        }
        return book(at: currentIndex)
    }
    
    var favoriteBooks: [Book] = []
    
    func append(book: Book){
        books.append(book)
    }
    
    func insert(book: Book, at index: Int){
        if (index > books.count - 1) || (index < 0){
            append(book: book)
        }
        else{
            books.insert(book, at: index)
        }
    }
    
    func removeBooking(at index: Int){
        if (index >= 0 && index <= books.count - 1){
            books.remove(at: index)
        }
        else{
            return
        }
    }
    
    func book(at index: Int) -> Book?{
        if (index > books.count - 1) || (index < 0){
            return nil;
        }
        return books[index]
    }
    
    func getIndex(for book: Book) -> Int?{
        var index = 0;
        for i in books{
            if i == book{
                return index
            }
            index += 1
        }
        return nil
    }
    
    func update(book: Book, at index: Int){
        books[index] = book
    }
}

