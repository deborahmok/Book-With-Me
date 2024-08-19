//
//  PhotoPickerView.swift
//  StudyWithMe
//
//  Created by Deborah Mok on 4/24/24.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: UIViewControllerRepresentable {
    // This struct represents a view that picks a photo and binds it to the selectedPhoto property
    @Binding var selectedPhoto: Photo?
    
    // This method creates the PHPickerViewController
    func makeUIViewController(context: Context) -> PHPickerViewController {
        // Configuring PHPickerViewController to pick images from the photo library
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.filter = .images
        
        // Creating the PHPickerViewController with the configured settings
        let picker = PHPickerViewController(configuration: configuration) // Setting the delegate to the Coordinator
        picker.delegate = context.coordinator
        return picker
    }
    
    // This method updates the PHPickerViewController
    func updateUIViewController(_ viewController: PHPickerViewController, context: Context) {}
    
    // This method creates a Coordinator for managing interactions with the PHPickerViewController
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // Coordinator class to handle PHPickerViewControllerDelegate methods
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PhotoPickerView
        
        // Coordinator initialization
        init(_ parent: PhotoPickerView) {
            self.parent = parent
        }
        
        // Called when the user finishes picking photos
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            // Check if any results are returned
            guard let result = results.first else { return }
            
            // Load the selected image from the result
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                guard let self = self, let image = image as? UIImage, error == nil else {
                    return
                }
                // Create a Photo object from the selected image and set it to the selectedPhoto property
                let photo = Photo(image: image, createdDate: Date())
                self.parent.selectedPhoto = photo
            }
        }

    }
}

