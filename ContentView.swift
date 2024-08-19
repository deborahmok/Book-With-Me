//
//  ContentView.swift
//  StudyWithMe
//
//  Created by Deborah Mok on 4/7/24.
//
import SwiftUI

struct ContentView: View {
    @Binding var isUserLoggedIn: Bool // Changed to binding
    
    var body: some View {
        Group {
            if isUserLoggedIn {
                MainTabView(isUserLoggedIn: $isUserLoggedIn) // Pass isUserLoggedIn binding
            } else {
                LandingPage(isUserLoggedIn: $isUserLoggedIn)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(isUserLoggedIn: .constant(false)) // Provide a default value
    }
}
