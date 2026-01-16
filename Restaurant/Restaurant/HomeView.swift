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
            Tab(value: .menu) {
                MenuView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .position(x: 201, y:435)
            }
            
            Tab(value: .userPrfile) {
                UserProfileView()
            }
        }
        .navigationBarBackButtonHidden(true)
        .safeAreaInset(edge: .top) {
            HeaderView(viewToRender: $viewToRender)
        }
        .environment(navigationPath)
    }
}

#Preview {
    HomeView().environment(Path())
}
