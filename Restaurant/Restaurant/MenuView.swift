//
//  MenuView.swift
//  Restaurant
//
//  Created by Liene Zegele on 1/8/26.
//

import SwiftUI
import CoreData

struct MenuView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var dishesModel = DishesModel()
    @State var searchText = ""
    
    @FetchRequest(
        sortDescriptors:
            [NSSortDescriptor(keyPath: \Dish.title, ascending: true)],
        animation: .default)
    private var dishesT: FetchedResults<Dish>

    var body: some View {
        VStack {
            HeroView(searchText: $searchText)
            
            FetchedObjects(
                predicate:buildPredicate(),
                sortDescriptors: buildSortDescriptors()
            ) { (dishes: [Dish]) in
                VStack {
                    List {
                        ForEach(dishes, id: \.self) { dish in
                            NavigationLink(destination: ItemDetailsView(dish)) {
                                MenuItemBoxView(dish)
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .padding(0)
                }
            }
        }
        .task {
            await dishesModel.getMenuData(viewContext)
        }
    }
    
    func buildPredicate() -> NSPredicate {
        if searchText == "" {
            return NSPredicate(value: true)
        }
        
        return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(
                key: "title",
                ascending: true,
                selector: #selector(NSString .localizedStandardCompare(_:)))]
    }

}

#Preview {
    let persistenceController = PersistenceController.shared
    MenuView()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
}
