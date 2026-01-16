//
//  WelcomeView.swift
//  Restaurant
//
//  Created by Liene Zegele on 1/15/26.
//

import SwiftUI

struct WelcomeView: View {
    @State var name: String = ""
    @State var showAlert: Bool = false
    @Binding var selection: Tabees
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Welcome! \nThree questions to set up your Little Lemon profile.\n")
                .multilineTextAlignment(.center)
                .font(Font.custom("MarkaziText-Medium", size: 52))
                .foregroundStyle(Color.lemonYellow)
                
            Text("Your name?")
                .font(Font.custom("MarkaziText-Medium", size: 42))
                .foregroundStyle(Color.lemonWhite)
                .multilineTextAlignment(.center)
                .frame(alignment: .leading)
            
            TextField("name", text: $name)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.lemonWhite))
                .multilineTextAlignment(.center)
                
       
            Button("**Next**") {
                if !name.isEmpty {
                    UserDefaults.standard.set(name, forKey: kFirstName)
                    name = ""
                    selection = Tabees.lastName
                } else {
                    showAlert.toggle()
                }
            }
            .font(.title2)
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundStyle(Color.lemonGreen)
            .background(Color(Color.lemonYellow))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .alert(isPresented: self.$showAlert) {
                Alert(title: Text("Name must be provided to use app."))
            }

        }
        .padding()
        //.textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

#Preview {
    @Previewable @State var curentTab = Tabees.name
    WelcomeView(selection: $curentTab)
}
