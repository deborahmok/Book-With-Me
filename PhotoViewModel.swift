//
//  PhotoViewModel.swift
//  StudyWithMe
//
//  Created by Deborah Mok on 4/24/24.
//

import Foundation
import UIKit
import Photos

class PhotoViewModel: ObservableObject {
    @Published var photos: [Photo] = []{
        didSet {
            save()
        }
    }
    
    private var photoFilePath : URL
    @Published var currentIndex = 0{
        didSet {
            //not to go out of bounds
            if currentIndex < 0 || currentIndex >= photos.count{
                print("Out of bounds")
            }
        }
    }
    
    init() {
        photoFilePath = FileManager.default.urls(for: .documentDirectory,
                                                      in: .userDomainMask).first!.appendingPathComponent("photos.json")
        // try to load flashcards
        if let photos = load() {
            self.photos = photos
        }
    }
    
    // Attempts to read from disk and decodes from JSON into Swift objects
    private func load() -> [Photo]?{
        // Your implementation here
        do {
            let data = try Data(contentsOf: photoFilePath)
            let photos = try JSONDecoder().decode([Photo].self, from: data)
            return photos
        } catch {
            return nil
        }
    }
    
    // Attemps to encodes Swift objects into JSON and saves to disk
    private func save(){
        // Your implementation here
        do {
            let data = try JSONEncoder().encode(photos)
            try data.write(to: photoFilePath)
        } catch {
            print("Error saving photo: \(error)")
        }
    }
    
    func addPhoto(_ photo: Photo) {
        photos.append(photo)
        persistPhoto(photo)
    }
    
    func removePhoto(_ photo: Photo) {
        if let index = photos.firstIndex(where: { $0.id == photo.id }) {
            photos.remove(at: index)
            deletePhoto(photo)
        }
    }
    
    private func persistPhoto(_ photo: Photo) {
        // Persist the photo to the device's photo library
        PHPhotoLibrary.shared().performChanges {
            let creationRequest = PHAssetCreationRequest.forAsset()
            creationRequest.addResource(with: .photo, data: photo.image, options: nil)
        } completionHandler: { success, error in
            if let error = error {
                print("Error saving photo to photo library: \(error.localizedDescription)")
            } else {
                print("Photo saved to photo library successfully!")
            }
        }
    }
    
    private func deletePhoto(_ photo: Photo) {
        // Convert the UUID to a URL
        let assetURL = PHAsset.fetchAssets(withLocalIdentifiers: [photo.id.uuidString], options: nil).firstObject?.value(forKey: "localIdentifier") as? URL

        if let assetURL = assetURL {
            // Delete the photo from the device's photo library
            PHPhotoLibrary.shared().performChanges {
                PHAssetChangeRequest.deleteAssets([assetURL] as NSArray)
            } completionHandler: { success, error in
                if let error = error {
                    print("Error deleting photo from photo library: \(error.localizedDescription)")
                } else {
                    print("Photo deleted from photo library successfully!")
                }
            }
        }
    }
}
