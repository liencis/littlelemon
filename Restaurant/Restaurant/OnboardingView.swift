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

let kIsLoggedIn = "kIsLoggedIn"

enum Screen: Hashable {
    case home, profile
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
                case Screen.profile:
                    UserProfileView()
                }
            }
            .environment(navigationPath)
            .background(Color.lemonGreen)
        }
    }
}

#Preview {
    OnboardingView()
}
