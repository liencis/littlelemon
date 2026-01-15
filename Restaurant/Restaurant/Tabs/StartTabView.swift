//
//  StartTabView.swift
//  Restaurant
//
//  Created by Liene Zegele on 1/14/26.
//

import SwiftUI

struct StartTabView: View {
    @State var selectedTab: TabViewEnum = .menu
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(TabViewEnum.allCases) { tab in
                let tabItem = tab.tabItem
                Tab(tabItem.name, systemImage: tabItem.imageName, value: tab) {
                    tab
                }
                
            }
        }
    }
}

#Preview {
    StartTabView()
}
