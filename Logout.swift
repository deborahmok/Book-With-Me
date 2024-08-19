//
//  Logout.swift
//  StudyWithMe
//
//  Created by Deborah Mok on 4/26/24.
//

import SwiftUI

import SwiftUI
import GoogleSignInSwift
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

struct Logout: View {
    var body: some View {
        VStack{
            Button("Log Out", action: signOut)
        }
    }
    
    func signOut() {
      GIDSignIn.sharedInstance.signOut()
    }
}

#Preview {
    Logout()
}
