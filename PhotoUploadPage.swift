//
//  PhotoUploadPage.swift
//  StudyWithMe
//
//  Created by Deborah Mok on 4/25/24.
//

import SwiftUI

struct PhotoUploadPage: View {
    @ObservedObject var viewModel: PhotoViewModel
    @State private var selectedPhoto: Photo?
    //design
    var body: some View {
        NavigationView {
            VStack {
                //connecting the selected photo
                PhotoPickerView(selectedPhoto: $selectedPhoto)
                    .onChange(of: selectedPhoto) { photo in
                        if let photo = photo {
                            viewModel.addPhoto(photo)
                        }
                    }
            }
            .padding()
            .navigationBarTitle("Upload Photos")
            Spacer()
        }
    }
}
