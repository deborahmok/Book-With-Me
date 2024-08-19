//
//  PhotoPage.swift
//  StudyWithMe
//
//  Created by Deborah Mok on 4/24/24.
//

import SwiftUI

struct PhotoPage: View {
    @StateObject private var viewModel = PhotoViewModel()
    @State private var selectedPhoto: Photo?
    
    var body: some View {
        //design
        NavigationView {
            VStack {
                
                NavigationLink(destination: PhotoUploadPage(viewModel: viewModel)){
                    Text("Upload Photos")
                }
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                        ForEach(viewModel.photos) { photo in
                            Image(uiImage: UIImage(data: photo.image)!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .onTapGesture {
                                    viewModel.removePhoto(photo)
                                }
                        }
                    }
                }
            }
            .padding()
            .navigationBarTitle("Photo Notes")
        }
    }
}

#Preview {
    PhotoPage()
}
