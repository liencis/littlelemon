//
//  HeaderView.swift
//  Restaurant
//
//  Created by Liene Zegele on 1/14/26.
//

import SwiftUI

struct HeaderView: View {
    var imageString = UserDefaults.standard.string(forKey: kIsLoggedIn)
    
    //@Binding var path: NavigationPath
    var body: some View {
        HStack {
            Image(systemName: "arrow.backward.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundStyle(Color.lemonGreen)
                .padding()
            Spacer()
            Image("HeaderLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 40)
            Spacer()
            Button() {
                
            } label: {
                Image("profile-image-placeholder")//imageString ?? "profile-image-placeholder")
                    .resizable()
                    .frame(maxWidth: 40, maxHeight: 40)
                    .clipShape(.rect(cornerRadius: 50))
                    .padding()
                    //.background(Color.white, in: .circle)
            }
            .frame(alignment: .trailing)
        }
        .frame(maxWidth: .infinity, maxHeight: 70, alignment: .top)
    }
}

#Preview {
    HeaderView()//(path: .constant(NavigationPath()))
}

