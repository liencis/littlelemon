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
    @State var categorySelected: [MenuCategory] = []
    
    @FetchRequest(
        sortDescriptors:
            [NSSortDescriptor(keyPath: \Dish.title, ascending: true)],
        animation: .default)
    private var dishesT: FetchedResults<Dish>

    var body: some View {
        VStack {}.frame(maxWidth: .infinity, minHeight: 60)
        VStack {
            HeroView(searchText: $searchText)
            MenuCategoryView(categorySelected: $categorySelected)
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
                }.padding(0)
            }
        }
        .task {
            await dishesModel.getMenuData(viewContext)
        }
    }
    
    func buildPredicate() -> NSCompoundPredicate {
        var predicates = [NSPredicate]()
        
        if searchText == "" && categorySelected.count == 0 {
            return NSCompoundPredicate(type: .and, subpredicates: [NSPredicate(value: true)])
        }
        
        if categorySelected.count > 0 {
            var categoryPredicate = [NSPredicate]()
            for cat in categorySelected {
                categoryPredicate.append(NSPredicate(format: "category == %@", cat.name))
            }
            let categoryCompoundPredicate = NSCompoundPredicate(type: .or, subpredicates: categoryPredicate)
            
            predicates.append(categoryCompoundPredicate)
        }
        
        if !searchText.isEmpty {
            predicates.append(NSPredicate(format: "title CONTAINS[cd] %@", searchText))
        }
        
        return NSCompoundPredicate(type: .and, subpredicates: predicates)
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
