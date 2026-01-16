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

struct User {
    var name: String
    var lastName: String
    var email: String
}


struct UserInfoFormView: View {
    @State var inputString: String = ""
    @State var selection: Tabees = .name
    @State var user = User(name: "", lastName: "", email: "")
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
//                WelcomeView(selection: $selection)
//                    .tabItem() { Label("Welcome", systemImage: "") }
//                    .tag(Tabees.name)
//                LastNameView(selection: $selection)
//                    .tabItem() { Label("Last name", systemImage: "") }
//                    .tag(Tabees.lastName)
//                EmailView(selection: $selection)
//                    .tabItem() { Label("Email", systemImage: "") }
//                    .tag(Tabees.email)
//                    .environment(navigationPath)
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
