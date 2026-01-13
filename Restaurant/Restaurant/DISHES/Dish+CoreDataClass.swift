//
//  Dish+CoreDataClass.swift
//  Restaurant
//
//  Created by Liene Zegele on 1/9/26.
//
//

import Foundation
import CoreData

@objc(Dish)
public class Dish: NSManagedObject {
    func formatPrice() -> String {
        let spacing = price < 10 ? " " : ""
        return "$ " + spacing + String(format: "%.2f", price)
    }
}
