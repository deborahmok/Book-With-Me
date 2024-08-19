////
////  LandingPage.swift
////  StudyWithMe
////
////  Created by Deborah Mok on 4/30/24.
////

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct LandingPage: View {
    @Binding var isUserLoggedIn: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                //design
                VStack {
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(Color(.systemCyan))
                        Text("Book")
                    }
                    .font(.system(size: 60, design: .serif))
                    Text("With Me!")
                        .font(.system(size: 55, design: .serif))
                }
                .fontWeight(.bold)
                .padding(10)
                //button asking user what way to log in
                VStack {
                    Button("Login with Google", action: handleSignInButton)
                    
                    Text("or")
                        .padding(5)
                        .foregroundColor(.black)
                    //taking to a page if the user wants to log in with email
                    NavigationLink(destination: LoginWithEmail(isUserLoggedInWithEmail: $isUserLoggedIn)) {
                        Text("Login with Email")
                    }
                }
                .foregroundColor(Color(.systemCyan))
            }
            Spacer(minLength: 200)
        }
    }
    //google sign in button function
    func handleSignInButton() {
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else { return }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { signInResult, error in
            guard let _ = signInResult else {
                // Handle error
                return
            }
            // If sign in succeeded, set isUserLoggedIn to true.
            isUserLoggedIn = true
        }
    }
}
