//
//  UserProfileView.swift
//  Restaurant
//
//  Created by Liene Zegele on 1/8/26.
//

import SwiftUI

struct UserProfileView: View {
    // @Environment(\.presentationMode) var presentation
    
    @Binding var path: NavigationPath
    
    // If you decide to use UserDefaults in your app, don’t forget to add PrivacyManifest file to your app or your app review may get denied. Learn how to set that up here: https://medium.com/@jpmtech/privacy-manifest-for-your-ios-app-bce634c1b619
    
    var firstName = UserDefaults.standard.string(forKey: kFirstName)
    var lastName = UserDefaults.standard.string(forKey: kLastName)
    var email = UserDefaults.standard.string(forKey: kEmail)

    var body: some View {
        VStack {
            Text("Personal information")
            Image("profile-image-placeholder")
            Text(firstName ?? "name placeholder")
            Text(lastName ?? "last name placeholder")
            Text(email ?? "email placeholder")
            Spacer()
            Button("Log Out") {
                //                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                //                self.presentation.wrappedValue.dismiss()
                logOutClicked()
            }
        }
    }
    
    func logOutClicked() {
        UserDefaults.standard.removeObject(forKey: kFirstName)
        UserDefaults.standard.removeObject(forKey: kLastName)
        UserDefaults.standard.removeObject(forKey: kEmail)
        path.removeLast()
    }
}

#Preview {
    UserProfileView(path: .constant(NavigationPath()))
}
