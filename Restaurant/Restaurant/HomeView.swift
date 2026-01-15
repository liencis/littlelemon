//
//  HomeView.swift
//  Restaurant
//
//  Created by Liene Zegele on 1/8/26.
//

import SwiftUI

struct HomeView: View {
    let persistenceController = PersistenceController.shared
    
    @State var viewToRender: TabViewEnum = .menu
    @Environment(Path.self) var navigationPath
    
    var body: some View {
        TabView(selection: $viewToRender) {
            MenuView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .tabItem() { Label("Menu", systemImage: "list.dash") }
                .position(x: 201, y:435)
            
            UserProfileView()//(path: $path)
                .tabItem() { Label("Profile", systemImage: "square.and.pencil") }
        }
        .navigationBarBackButtonHidden(true)
        .safeAreaInset(edge: .top) {
            HeaderView()//(path: $path)
        }
        .environment(navigationPath)
    }
}

#Preview {
    HomeView().environment(Path())
}
