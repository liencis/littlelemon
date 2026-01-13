//
//  MenuView.swift
//  Restaurant
//
//  Created by Liene Zegele on 1/8/26.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var dishesModel = DishesModel()

    var body: some View {
        VStack {
            VStack {
                Text("Little Lemon")
                HStack {
                    VStack {
                        Text("Chicago")
                        Text("We  are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                    }
                    // Place for image
                }
            }
            FetchedObjects(
                //predicate:buildPredicate(),
                sortDescriptors: buildSortDescriptors()
            ) { (dishes: [Dish]) in
                List {
                    ForEach(dishes, id: \.self) { dish in
                        NavigationLink(destination: ItemDetailsView(dish)) {
                            HStack() {
                                Text(dish.title ?? "")
                                Text("$ \(String(dish.price))")
                                Spacer()
                                AsyncImage(url: URL(string: dish.image ?? "https://imgur.com/nIT7Agk.jpg")) {image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 50, height: 50)
                            }
                        }
                    }
                }
            }.navigationBarTitle("Menu")
        }
        .task {
            await dishesModel.getMenuData(viewContext)
        }
    }
    
//    func buildPredicate() -> NSPredicate {
//        if searchText == "" {
//            return NSPredicate(value: true)
//        }
//        
//        return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
//    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(
                key: "title",
                ascending: true,
                selector: #selector(NSString .localizedStandardCompare(_:)))]
    }

}

#Preview {
    MenuView()
}
