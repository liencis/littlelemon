//
//  MenuItemBoxView.swift
//  Restaurant
//
//  Created by Liene Zegele on 1/17/26.
//

import SwiftUI

struct MenuItemBoxView: View {
    @ObservedObject private var item: Dish
    
    init(_ item: Dish) {
        self.item = item
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.title ?? "")
                .font(.custom("Karla-Bold", size: 21))
                .foregroundStyle(Color.lemonDark)
            
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(item.itemDescription ?? "")
                        .font(.custom("Karla-Regular", size: 18))
                        .lineLimit(2)
                    Text(item.formatPrice())
                        .font(.custom("Karla-Medium", size: 18))
                }
                .foregroundStyle(Color.lemonGreen)
                
                Spacer()
                
                AsyncImage(url: URL(string: item.image ?? "")) {image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 70, height: 70)
            }
        }
    }
}

//#Preview {
//    MenuItemBoxView()
//}

struct MenuItemBoxView_Previews: PreviewProvider {
    static let context = PersistenceController.shared.container.viewContext
    let item = Dish(context: context)
    
    static var previews: some View {
        MenuItemBoxView(oneDish())
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
