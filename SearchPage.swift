//
//  SearchPage.swift
//  StudyWithMe
//
//  Created by Deborah Mok on 4/19/24.
//

import SwiftUI

struct SearchPage: View {
    //design
    @Environment(\.dismiss) private var dismiss
    @StateObject private var searchManager = SearchManager()
    @State private var search: String = ""
    @StateObject private var viewModel = SearchResultsViewModel()
    @Binding var finalPlace: String
    
    var body: some View {
        NavigationView{
            VStack{
                List(viewModel.places){ place in
                    Button(action: {
                        finalPlace = place.name
                        dismiss()
                    }, label: {
                        Text(place.name)
                    })
                    
                }
                
            }.searchable(text: $search)
                .onChange(of: search, perform: { searchText in
                    
                    if !searchText.isEmpty {
                        viewModel.search(text: searchText, region: searchManager.region)
                    }
                    else {
                        viewModel.places = []
                    }
                })
            .navigationTitle("Search")
        }
    }
}

#Preview {
    SearchPage(finalPlace: .constant(""))
}
