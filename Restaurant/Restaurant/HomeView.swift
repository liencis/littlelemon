//
//  HomeView.swift
//  Restaurant
//
//  Created by Liene Zegele on 1/8/26.
//

import SwiftUI

struct HomeView: View {
    let persistenceController = PersistenceController.shared
    @Binding var path: NavigationPath
    
    var body: some View {
        TabView {
            MenuView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .tabItem() { Label("Menu", systemImage: "list.dash") }
            UserProfileView(path: $path)
                .tabItem() { Label("Edit Profile", systemImage: "square.and.pencil") }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView(path: .constant(NavigationPath()))
}
