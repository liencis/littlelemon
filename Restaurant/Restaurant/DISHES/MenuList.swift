//
//  MenuList.swift
//  Restaurant
//
//  Created by Liene Zegele on 1/9/26.
//

import Foundation

struct MenuList: Codable {
    let menu: Array<MenuItem>
    
    enum CodingKeys: String, CodingKey {
        case menu = "menu"
    }
}
