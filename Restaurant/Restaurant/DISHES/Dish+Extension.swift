//
//  Dish+Extension.swift
//  Restaurant
//
//  Created by Liene Zegele on 1/8/26.
//
//
//import Foundation
//import CoreData
//
//
//extension Dish {
//    
////    class func saveDatabase(_ context:NSManagedObjectContext) {
////        guard context.hasChanges else { return}
////        do {
////            try context.save()
////        } catch (let error) {
////            print(error.localizedDescription)
////        }
////    }
//    
//    static func exists(name: String,
//                       _ context:NSManagedObjectContext) -> Bool? {
//        let request = Dish.request()
//        let predicate = NSPredicate(format: "name CONTAINS[cd] %@", name)
//        request.predicate = predicate
//        
//        do {
//            guard let results = try context.fetch(request) as? [Dish]
//            else {
//                return nil
//            }
//            return results.count > 0
//        } catch (let error){
//            print(error.localizedDescription)
//            return false
//        }
//    }
//
//    
//    static func createDishesFrom(menuItems:[MenuItem],
//                                 _ context:NSManagedObjectContext) {
//        for item in menuItems {
//            guard let _ = exists(name: item.title, context) else { continue }
//            
//            let dish = Dish(context: context)
//            dish.name = item.title
//            dish.price = Float(item.price) ?? 0.0
//            dish.itemDescription = item.description
//            dish.image = item.imageUrl
//        }
//        // saveDatabase(context)
//    }
//    
//}
