//
//  EditBookingPage.swift
//  StudyWithMe
//
//  Created by Deborah Mok on 4/10/24.
//
import SwiftUI

struct EditBookingPage: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var bookingViewModel : BookingViewModel
    private var book : Book?
    @State private var name = ""
    @State private var time = Date()
    @State private var location = ""
    
    init(book: Book? = nil){
        guard let book else {
            return
        }
        self.book = book
        _name = State(initialValue: book.name)
        _time = State(initialValue: book.time)
        _location = State(initialValue: book.location)
    }
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading){
                if (book != nil) {
                    TextField(book!.name, text: $name)
                 
                    NavigationLink(destination: SearchPage(finalPlace: $location)){
                        Text(location)
                    }
                    
                    DatePicker("Time: ",
                               selection: $time,
                               displayedComponents: [.hourAndMinute, .date])
                }
                else
                {
                    TextField("Name: ", text: $name)
                    
                
                    NavigationLink(destination: SearchPage(finalPlace: $location)){
                        Text(location.isEmpty ? "Location" : location)
                    }
                    
                    HStack {
                        DatePicker("Time: ",
                                   selection: $time,
                                   displayedComponents: [.hourAndMinute, .date])
                    }
                }
                
            }
            .padding()
            .navigationTitle(book == nil ? "New Booking" : "Edit Booking")
            .toolbar{
                Button("Save"){
                    if (book != nil){
                        let updateBooking = Book(id: UUID().uuidString, name: name, time: time, location: location)
                        let curIdx = bookingViewModel.getIndex(for: book!)
                        bookingViewModel.update(book: updateBooking, at: curIdx!)
                    }
                    else{
                        bookingViewModel.append(book: Book(id: UUID().uuidString, name: name, time: time, location: location))
                    }
                    dismiss()
                }
                .disabled(name == "" || location == "")
            }
        }
    }
}

#Preview {
    EditBookingPage()
}
