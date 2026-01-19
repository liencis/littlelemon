//
//  HeaderView.swift
//  Restaurant
//
//  Created by Liene Zegele on 1/14/26.
//

import SwiftUI

struct HeaderView: View {
    @Binding var viewToRender: TabViewEnum
    
    let imageString = UserDefaults.standard.string(forKey: kIsLoggedIn)
    @Environment(UserImage.self) var user
    
    //@Binding var path: NavigationPath
    var body: some View {
        HStack {
            Button() {
                viewToRender = TabViewEnum.menu
            } label: {
                Image(systemName: "arrow.backward.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(viewToRender == TabViewEnum.userPrfile ? Color.lemonGreen : Color.clear)
                    .padding()
            }
            
            Spacer()
            Image("HeaderLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 40)
            Spacer()
            
            Button() {
                viewToRender = TabViewEnum.userPrfile
            } label: {
                Image(uiImage: user.uiImage)//imageString ?? "profile-image-placeholder")
                    .resizable()
                    .frame(maxWidth: 40, maxHeight: 40)
                    .clipShape(.rect(cornerRadius: 50))
                    .padding(5)
                    .overlay() {
                        Circle()
                            .stroke(Color.lemonGreen, lineWidth: 3)
                    }
                    .padding(10)
                    //.background(Color.white, in: .circle)
            }
            .frame(alignment: .trailing)
        }
        .frame(maxWidth: .infinity, maxHeight: 70, alignment: .top)
    }
}

#Preview {
    @Previewable @State var section = TabViewEnum.menu
    HeaderView(viewToRender: $section)
        .environment(UserImage())
}

