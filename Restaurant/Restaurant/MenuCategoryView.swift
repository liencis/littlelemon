//
//  MenuCategoryView.swift
//  Restaurant
//
//  Created by Liene Zegele on 1/20/26.
//

import SwiftUI

struct MenuCategory: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var isActive: Bool
}

struct MenuCategoryView: View {
    @Binding var categorySelected: [MenuCategory]
    @State var categories = [
        MenuCategory(name: "Mains", isActive: false),
        MenuCategory(name: "Beverages", isActive: false),
        MenuCategory(name: "Salads", isActive: false),
        MenuCategory(name: "Appetizers", isActive: false),
        MenuCategory(name: "Desserts", isActive: false),
    ]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach($categories, id: \.self) { $cat in
                    Button() {
                        cat.isActive.toggle()
                        if cat.isActive == true {
                            categorySelected.append(cat)
                        } else {
                            if categorySelected.contains(where: {$0.name == cat.name}) {
                                categorySelected.remove(at: categorySelected.firstIndex(where: {$0.name == cat.name})!)
                            }
                        }
                    } label: {
                        Text("\(cat.name)")
                            .font(.custom("Karla-Bold", size: 18))
                            .padding(10)
                            .background(cat.isActive ? Color.lemonGreen : Color.lemonWhite)
                            .foregroundStyle(cat.isActive ? Color.lemonWhite : Color.lemonGreen)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.leading, 10)
                }
            }
            Divider()
                .padding(3)
        }
    }
}

#Preview {
    @Previewable @State var im: [MenuCategory] = []
    MenuCategoryView(categorySelected: $im)
}
