//
//  HomeView.swift
//  Restaurant
//
//  Created by Liene Zegele on 1/8/26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            MenuView()
                .tabItem() { Label("Menu", systemImage: "list.dash") }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView()
}
