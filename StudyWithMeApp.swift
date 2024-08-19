//
//  StudyWithMeApp.swift
//  StudyWithMe
//
//  Created by Deborah Mok on 4/7/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import CoreData

let APIKey = "Password"

class AppDelegate: NSObject, UIApplicationDelegate {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "StudyWithMe")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Your code here")
        FirebaseApp.configure()
        
        //signin:
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
           if error != nil || user == nil {
             // Show the app's signed-out state.
           } else {
             // Show the app's signed-in state.
           }
         }
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        var handled: Bool

        handled = GIDSignIn.sharedInstance.handle(url)
        if handled {
          return true
        }

        // Handle other custom URL types.

        // If not handled by this app, return false.
        return false
    }
    
}

@main
struct StudyWithMeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var isUserLoggedIn = false // Add state for user login status

    var body: some Scene {
        WindowGroup {
            ContentView(isUserLoggedIn: $isUserLoggedIn) // Pass user login status
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
                .onAppear {
                    GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                        // Check if `user` exists; otherwise, do something with `error`
                        if let _ = user {
                            isUserLoggedIn = true // Update user login status
                            }
                    }
                }
            }
        }
}

