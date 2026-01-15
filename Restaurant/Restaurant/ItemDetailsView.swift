//
//  ItemDetailsView.swift
//  Restaurant
//
//  Created by Liene Zegele on 1/12/26.
//

import SwiftUI

struct ItemDetailsView: View {
    @ObservedObject private var item: Dish
    
    init(_ item: Dish) {
        self.item = item
    }
    
    @State var showAlert = false
    
    var body: some View {
        VStack(spacing: 10) {
            Text("**\(item.title ?? "Menu Item")**")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.largeTitle)
                .foregroundStyle(Color.lemonGreen)
                .padding(.bottom)
            
            AsyncImage(url: URL(string: item.image ?? "https://imgur.com/nIT7Agk.jpg")) {image in
                VStack {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            } placeholder: {
                ProgressView()
            }
            .frame(width: 300, height: 300, alignment: .top)
            .clipShape(.rect(cornerRadius: 16))
            .padding()
            
            Text("**Description:**").font(.title2).foregroundStyle(Color.lemonDark)
            Text(item.itemDescription ?? "Delicious meal from Little Lemon").foregroundStyle(Color.lemonDark)
            
            Text("**Price:** \(item.formatPrice())")
                .font(.title2)
                .foregroundStyle(Color.lemonDark)
                .padding()
            
            Button("Add to cart") {
                showAlert.toggle()
            }
            .font(.title2)
            .frame(maxWidth: .infinity)
            .padding()
//            .foregroundStyle(Color.lemonWhite)
            .background(Color(Color.lemonGreen))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .alert("\(item.title ?? "Menu Item") added to cart!",
                   isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
        }.padding()
    }
}

//#Preview {
//    let context = PersistenceController.shared.container.viewContext
//    let dish = Dish(context: context)
//    
//    func oneDish() -> Dish {
//        let dish = Dish(context: context)
//        dish.title = "Pasta"
//        dish.price = 12.45
//        dish.image = "https://imgur.com/DVfV9Gr.jpg"
//        dish.itemDescription = "Home made delicious pasta, hand cut."
//        return dish
//    }
//    
//    ItemDetailsView(item: oneDish())
//}

struct ItemsDetailView_Previews: PreviewProvider {
    static let context = PersistenceController.shared.container.viewContext
    let item = Dish(context: context)
    
    static var previews: some View {
        ItemDetailsView(oneDish())
    }
    
    static func oneDish() -> Dish {
        let item = Dish(context: context)
        item.title = "Pasta"
        item.price = 12.45
        item.image = "https://imgur.com/DVfV9Gr.jpg"
        item.itemDescription = "Home made delicious pasta, hand cut."
        return item
    }
}

