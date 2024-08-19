//
//  MainTabView.swift
//  StudyWithMe
//
//  Created by Deborah Mok on 4/24/24.
//

import SwiftUI

import SwiftUI

struct MainTabView: View {
    @Binding var isUserLoggedIn: Bool // Added binding
    
    @StateObject var bookingViewModel = BookingViewModel()
    
    var body: some View {
        TabView{
            BookPage(isUserLoggedIn: $isUserLoggedIn) // Pass isUserLoggedIn binding
                .tabItem{
                    Label("Book", systemImage: "list.clipboard")
                }
            PhotoPage()
                .tabItem {
                    Label ("Upload", systemImage: "square.and.arrow.up")
                }
        }
        .environmentObject(bookingViewModel)
    }
}
