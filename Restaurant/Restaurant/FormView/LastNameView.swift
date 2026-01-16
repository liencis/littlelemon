//
//  LastNameView.swift
//  Restaurant
//
//  Created by Liene Zegele on 1/15/26.
//

import SwiftUI

struct LastNameView: View {
    @State var lastName: String = ""
    @State var showAlert: Bool = false
    @Binding var selection: Tabees
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Your last name?")
                .font(Font.custom("MarkaziText-Medium", size: 42))
                .foregroundStyle(Color.lemonWhite)
                .multilineTextAlignment(.center)
                .frame(alignment: .leading)
            
            TextField("last name", text: $lastName)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.lemonWhite))
                .multilineTextAlignment(.center)
       
            Button("**Next**") {
                if !lastName.isEmpty {
                    UserDefaults.standard.set(lastName, forKey: kLastName)
                    lastName = ""
                    selection = Tabees.email
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
                Alert(title: Text("Last name must be provided to use app."))
            }

        }
        .padding()
    }
}

#Preview {
    @Previewable @State var curentTab = Tabees.lastName
    LastNameView(selection: $curentTab)
}
