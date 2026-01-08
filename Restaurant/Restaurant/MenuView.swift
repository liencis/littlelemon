//
//  MenuView.swift
//  Restaurant
//
//  Created by Liene Zegele on 1/8/26.
//

import SwiftUI

struct MenuView: View {
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
            List {}
        }
    }
}

#Preview {
    MenuView()
}
