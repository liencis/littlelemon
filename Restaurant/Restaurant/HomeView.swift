//
//  HomeView.swift
//  Restaurant
//
//  Created by Liene Zegele on 1/8/26.
//

import SwiftUI

@Observable
class UserImage {
    var uiImage: UIImage = UIImage(systemName: "person.fill")!
}

struct HomeView: View {
    @State var user = UserImage()
    let persistenceController = PersistenceController.shared
    
    @State var viewToRender: TabViewEnum = .menu
    @Environment(Path.self) var navigationPath
    
    var body: some View {
        TabView(selection: $viewToRender) {
            Tab(value: .menu) {
                MenuView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .toolbar(false ? .visible : .hidden, for: .tabBar) // Removing default
            }
            
            Tab(value: .userPrfile) {
                UserProfileView(user: $user)
                    .toolbar(false ? .visible : .hidden, for: .tabBar)
            }
        }
        .navigationBarBackButtonHidden(true)
        .safeAreaInset(edge: .top) {
            HeaderView(viewToRender: $viewToRender)
                .environment(user)
        }
        .environment(navigationPath)
    }
}

#Preview {
    HomeView().environment(Path())
}
