//
//  OnboardingView.swift
//  Restaurant
//
//  Created by Liene Zegele on 1/8/26.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"

let kIsLoggedIn = "kIsLoggedIn"

enum Screen: Hashable {
    case home
}

struct OnboardingView: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    
    @State var alertMesage: String = ""
    @State var showAlert: Bool = false
    
    @State var isLoggedIn: Bool = false

    @State var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                TextField("First name", text: $firstName)
                TextField("Last name", text: $lastName)
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                
                Button("Register") {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                        if isValidEmail(email) {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                            isLoggedIn = true
                            clearState()
                            path.append(Screen.home)
                        } else {
                            alertMesage = "Incorect email adress: \(email)"
                            showAlert.toggle()
                        }
                    } else {
                        alertMesage = "To finish registration you should provide all required information!"
                        showAlert.toggle()
                    }
                }
                .alert(isPresented: self.$showAlert) {
                    Alert(title: Text("\(alertMesage)"))
                }
            }
            .padding(12)
            .navigationDestination(for: Screen.self) { screen in
                switch screen {
                case Screen.home:
                    HomeView(path: $path)
                }
                //if value == "home" { HomeView(path: $path) }
            }
        }

            
    //        if isLoggedIn {
    //            NavigationStack { HomeView() }
    //        } else {
    //            NavigationStack {
    //                VStack {
    //                    TextField("First name", text: $firstName)
    //                    TextField("Last name", text: $lastName)
    //                    TextField("Email", text: $email)
    //                        .keyboardType(.emailAddress)
    //
    //                    Button("Register") {
    //                        if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
    //                            if isValidEmail(email) {
    //                                UserDefaults.standard.set(firstName, forKey: kFirstName)
    //                                UserDefaults.standard.set(lastName, forKey: kLastName)
    //                                UserDefaults.standard.set(email, forKey: kEmail)
    //                                UserDefaults.standard.set(true, forKey: kIsLoggedIn)
    //                                isLoggedIn = true
    //                            } else {
    //                                alertMesage = "Incorect email adress: \(email)"
    //                                showAlert.toggle()
    //                            }
    //                        } else {
    //                            alertMesage = "To finish registration you should provide all required information!"
    //                            showAlert.toggle()
    //                        }
    //                    }
    //                    .alert(isPresented: self.$showAlert) {
    //                        Alert(title: Text("\(alertMesage)"))
    //                    }
    //                }
    //                .padding(8)
    //                .onAppear() {
    //                    if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
    //                        isLoggedIn = true
    //                    } else { isLoggedIn = false }
    //                }
    //            }
    //        }
        }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func clearState() {
        // After savind data in UserDefaults clear state to not keep dat in memory
        
        firstName = ""
        lastName = ""
        email = ""
    }

}

#Preview {
    OnboardingView()
}
