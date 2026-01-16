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
    @Previewable @State var section = TabViewEnum.menu
    HeaderView(viewToRender: $section)
}

