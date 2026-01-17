//
//  Dish+Extension.swift
//  Restaurant
//
//  Created by Liene Zegele on 1/8/26.
//

import Foundation
import CoreData


extension Dish {
    
    static func exists(title: String,
                       _ context:NSManagedObjectContext) -> Bool? {
        let request = Dish.request()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", title)
        request.predicate = predicate
        
        do {
            guard let results = try context.fetch(request) as? [Dish]
            else {
                return nil
            }
   
            return results.count > 0
        } catch (let error){
            print(error.localizedDescription)
            return false
        }
    }

    
    static func createDishesFrom(menuItems:[MenuItem],
                                 _ context:NSManagedObjectContext) {
        for item in menuItems {
            guard let itemInDB = exists(title: item.title, context) else { continue }
            
            if itemInDB == false { // Check that item is not present in DB
                
                // Add item to Dish table in DB
                let dish = Dish(context: context)
                dish.title = item.title
                dish.price = Float(item.price) ?? 0.0
                dish.itemDescription = item.description
                dish.image = item.image
                
            }
        }
        try? context.save()
    }
    
}
