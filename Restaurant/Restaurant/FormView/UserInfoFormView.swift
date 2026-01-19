//
//  UserInfoFormView.swift
//  Restaurant
//
//  Created by Liene Zegele on 1/16/26.
//

import SwiftUI

enum Tabees {
    case name, lastName, email
}

struct EmailNotifications {
    var orderStatus: Bool
    var paswordChage: Bool
    var specialOffers: Bool
    var newsLetter: Bool
}

struct User {
    var name: String
    var lastName: String
    var email: String
    var phoneNumber: String
    var notifications: EmailNotifications
}


struct UserInfoFormView: View {
    @State var inputString: String = ""
    @State var selection: Tabees = .name
    @Environment(Path.self) var navigationPath
    
    var body: some View {
        VStack {
            TabView(selection: $selection){
                Tab(value: .name) {
                    WelcomeView(selection: $selection)
                }
                Tab(value: .lastName) {
                    LastNameView(selection: $selection)
                }
                Tab(value: .email) {
                    EmailView(selection: $selection)
                        .environment(navigationPath)
                }
            }
            .tabViewStyle(.page)
            .background(Color.lemonGreen)
        }
        
    }
}

#Preview {
    UserInfoFormView()
        .environment(Path())
}
