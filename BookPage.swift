//
//  BookPage.swift
//  StudyWithMe
//
//  Created by Deborah Mok on 4/10/24.
//

import SwiftUI
import GoogleSignInSwift
import GoogleSignIn
import FirebaseAuth

struct BookPage: View {
    @EnvironmentObject var bookingViewModel: BookingViewModel
    @Binding var isUserLoggedIn: Bool // Changed to binding
    
    var body: some View {
        if isUserLoggedIn {
            NavigationStack{
                List ($bookingViewModel.books, editActions: .delete){ $book in
                    NavigationLink(value: book) {
                        BookCell(book: book)
                    }
                }
                .navigationTitle("Bookings")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Logout", action: signOut)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: EditBookingPage()){
                            Image(systemName: "plus")
                        }
                    }
                })
            }
        }
        else{
            ContentView(isUserLoggedIn: $isUserLoggedIn) // Pass binding to ContentView
        }
    }
    
    func signOut() {
        if (GIDSignIn.sharedInstance.currentUser != nil){
            GIDSignIn.sharedInstance.signOut()
        }
        else{
            let firebaseAuth = Auth.auth()
            do {
              try firebaseAuth.signOut()
            } catch let signOutError as NSError {
              print("Error signing out: %@", signOutError)
            }
        }
        isUserLoggedIn = false // Update isUserLoggedIn state
    }
}
