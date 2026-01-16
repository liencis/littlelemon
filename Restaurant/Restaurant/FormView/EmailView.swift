//
//  EmailView.swift
//  Restaurant
//
//  Created by Liene Zegele on 1/16/26.
//

import SwiftUI

struct EmailView: View {
    @State var errorMesage = ""
    @State var email: String = ""
    @State var showAlert: Bool = false
    @Binding var selection: Tabees
    
    @Environment(Path.self) var navigationPath
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Your email?")
                .font(Font.custom("MarkaziText-Medium", size: 42))
                .foregroundStyle(Color.lemonWhite)
                .multilineTextAlignment(.center)
                .frame(alignment: .leading)
            
            TextField("email", text: $email)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.lemonWhite))
                .multilineTextAlignment(.center)
                .keyboardType(.emailAddress)
            
            Button("**Submit**") {
                let firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
                let lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
                
                if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                    if isValidEmail(email) {
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        UserDefaults.standard.set("profile-image-placeholder", forKey: kImageName)
                        email = ""
                        navigationPath.path.append(Screen.home)
                        selection = .name
                    } else {
                        errorMesage = "Email addres: \(email) is not formated correctly."
                        showAlert.toggle()
                    }
                } else {
                    errorMesage = "All required fields should be provided."
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
                Alert(title: Text("\(errorMesage)"))
            }
            
        }
        .padding()
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

#Preview {
    @Previewable @State var curentTab = Tabees.email
    EmailView(selection: $curentTab)
        .environment(Path())
}
