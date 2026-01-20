//
//  OnboardingView.swift
//  Restaurant
//
//  Created by Liene Zegele on 1/8/26.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"
let kImageName = "kImageName"
let kPhoneNumber = "kPhoneNumber"
let kNotifications = "kNotifications"

let kIsLoggedIn = "kIsLoggedIn"

enum Screen: Hashable {
    case home
}

@Observable
class Path {
    var path: Array<Screen> = []
}

struct OnboardingView: View {
    @State var navigationPath = Path()
    
    var body: some View {
        NavigationStack(path: $navigationPath.path) {
            VStack {
                UserInfoFormView()
                    .environment(navigationPath)
            }
            .padding()
            .navigationDestination(for: Screen.self) { screen in
                switch screen {
                case Screen.home:
                    HomeView()
                        .environment(navigationPath)
                }
            }
            .environment(navigationPath)
            .background(Color.lemonGreen)
        }
        .onAppear(){
            if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                navigationPath.path.append(.home)
            }
        }
    }
}

#Preview {
    OnboardingView()
}
