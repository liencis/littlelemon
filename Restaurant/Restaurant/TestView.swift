//
//  TestView.swift
//  Restaurant
//
//  Created by Liene Zegele on 1/13/26.
//

import SwiftUI

struct TestView: View {
    @State var searchText = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Little Lemon")
                .font(Font.custom("MarkaziText-Medium", size: 52))
                .foregroundStyle(Color.lemonYellow)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 10))
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Chicago")
                        .font(Font.custom("MarkaziText-Medium", size: 32))
                        .foregroundStyle(Color.lemonWhite)
                    Text("We  are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                        .fixedSize(horizontal: false, vertical: true)
                        .font(Font.custom("Karla-Regular", size: 18))
                        .foregroundStyle(Color.lemonWhite)
                }
                .padding(.leading, 15)
                .frame(alignment: .leading)
                
                Image("HeroImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 130, height: 130)
                    .clipShape(.rect(cornerRadius: 16))
                    .padding()
            }
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Color.lemonGreen)
                    .padding()
                TextField("Search menu", text: $searchText)
            }
            .frame(height: 35)
            .background(RoundedRectangle(cornerRadius: 12).fill(Color.lemonWhite))
            .padding()
//            .overlay(
//                RoundedRectangle(cornerRadius: 12)
//                    .stroke(lineWidth: 1)
//                    .foregroundStyle(Color.lemonGreen)
//                    .background(Color.lemonWhite)
//            )
        }
        .frame(maxWidth: .infinity, minHeight: 250)
        .background(Color.lemonGreen)
    }
}

#Preview {
    TestView()
}
