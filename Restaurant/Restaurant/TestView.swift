//
//  TestView.swift
//  Restaurant
//
//  Created by Liene Zegele on 1/13/26.
//

import SwiftUI

struct TestView: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    
    @State var inputString: String = ""
    @State var selection: Tabees = .name
    @State var user = User(name: "", lastName: "", email: "")
    
    @Environment(Path.self) var navigationPath
    
    var body: some View {
        VStack {
            TabView(selection: $selection){
                WelcomeView(selection: $selection)
                    .tabItem() { Label("Welcome", systemImage: "") }
                    .tag(Tabees.name)
                LastNameView(selection: $selection)
                    .tabItem() { Label("Last name", systemImage: "") }
                    .tag(Tabees.lastName)
                EmailView(selection: $selection)
                    .tabItem() { Label("Last name", systemImage: "") }
                    .tag(Tabees.email)
                    .environment(navigationPath)
            }
            .tabViewStyle(.page)
            .background(Color.lemonGreen)
        }
    }
    
}

#Preview {
    TestView()
}
