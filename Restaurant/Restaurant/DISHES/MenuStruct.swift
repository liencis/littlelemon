//
//  MenuStruct.swift
//  Restaurant
//
//  Created by Liene Zegele on 1/8/26.
//

import Foundation

struct JSONMenu: Codable {
    let menu: Array<MenuItem>
    
    enum CodingKeys: String, CodingKey {
        case menu = "menu"
    }
}


struct MenuItem: Codable, Identifiable {
    var id = UUID()
    let title: String
    let price: String
    let description: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case price = "price"
        case description = "description"
        case imageUrl = "https://imgur.com/nIT7Agk.jpg"
    }
}
