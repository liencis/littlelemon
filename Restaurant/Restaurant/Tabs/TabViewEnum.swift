//
//  TabViewEnum.swift
//  Restaurant
//
//  Created by Liene Zegele on 1/14/26.
//

import Foundation
import SwiftUI

enum TabViewEnum: Identifiable, CaseIterable {
    case menu, userPrfile
    var id: Self { self }
    
    var tabItem: TabItem {
        switch self {
        case .menu:
                .init(name: "Menu", imageName: "list.dash")
        case .userPrfile:
                .init(name: "Profile", imageName: "square.and.pencil")
        }
    }
}

