////
////  LoginWithEmail.swift
////  StudyWithMe
////
////  Created by Deborah Mok on 4/22/24.
////

import SwiftUI
import FirebaseAuth

struct LoginWithEmail: View {
    @State private var email = ""
    @State private var password = ""
    @Binding var isUserLoggedInWithEmail: Bool // Changed to binding

    var body: some View {
        VStack {
            VStack{
                TextField("Email: ", text: $email)
                SecureField("Password: ", text: $password) // Use SecureField for password entry
            }
            .padding(10)
            
            HStack {
                Button("Sign Up") {
                    Task {
                        do {
                            // Registering the user into firebase
                            let result = try await Auth.auth().createUser(withEmail: email, password: password)
                            let userID = result.user.uid
                            let email = result.user.email
                            isUserLoggedInWithEmail = true // Update binding
                        } catch {
                            print(error)
                        }
                    }
                }
                .disabled(email.isEmpty || password.isEmpty)
                
                Text("or")
                
                NavigationLink(destination: MainTabView(isUserLoggedIn: $isUserLoggedInWithEmail), isActive: $isUserLoggedInWithEmail) { // Pass binding
                    Button("Sign In") {
                        Task {
                            do {
                                // Checking if the login user exists in firebase
                                try await Auth.auth().signIn(withEmail: email, password: password)
                                isUserLoggedInWithEmail = true // Update binding
                            } catch {
                                print(error)
                            }
                        }
                    }
                }
            }
        }
    }
}



