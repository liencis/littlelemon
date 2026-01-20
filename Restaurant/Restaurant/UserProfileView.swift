//
//  UserProfileView.swift
//  Restaurant
//
//  Created by Liene Zegele on 1/8/26.
//

import SwiftUI
import PhotosUI

struct EmailNotifications: Codable {
    var orderStatus: Bool
    var paswordChage: Bool
    var specialOffers: Bool
    var newsLetter: Bool
}

struct User: Codable {
    var name: String
    var lastName: String
    var email: String
    var phoneNumber: String
    var notifications: EmailNotifications
}



struct UserProfileView: View {
    @Environment(Path.self) var navigationPath
    @Binding var user: UserImage
    
    @State var showAlert = false
    @State var alertMesage = ""

    
    @State var selectedPhotos = [PhotosPickerItem]()
    @State private var selectedImageData: Data? = nil

    let maxPhotosToSelect = 1
    
    @State var appUser = User(
        name: "",
        lastName: "",
        email: "",
        phoneNumber: "",
        notifications: EmailNotifications(
            orderStatus: true,
            paswordChage: true,
            specialOffers: true,
            newsLetter: true
        )
    )
    
    // If you decide to use UserDefaults in your app, don’t forget to add PrivacyManifest file to your app or your app review may get denied. Learn how to set that up here: https://medium.com/@jpmtech/privacy-manifest-for-your-ios-app-bce634c1b619

    var body: some View {
        VStack {}.frame(maxWidth: .infinity, minHeight: 70)
        ScrollView {
            VStack(alignment: .leading) {
                Text("Personal information")
                    .font(.custom("Karla-Bold", size: 24))
                    .foregroundStyle(Color.lemonDark)
                
                Section(header: Text("Avatar")
                    .font(.custom("Karla-Medium", size: 14))
                    .foregroundStyle(Color.gray)
                    .padding(2)
                ) {
                    HStack {
                        Image(uiImage: user.uiImage)
                            .resizable()
                            .frame(maxWidth: 60, maxHeight: 60)
                            .aspectRatio(contentMode: .fill)
                            .clipShape(.rect(cornerRadius: 60))
                            .padding(5)
                            .overlay() {
                                Circle()
                                    .stroke(Color.lemonGreen, lineWidth: 3)
                            }
                            .padding(10)
                        
                        PhotosPicker(
                            selection: $selectedPhotos, // holds the selected photos from the picker
                            maxSelectionCount: maxPhotosToSelect, // sets the max number of photos the user can select
                            selectionBehavior: .ordered, // ensures we get the photos in the same order that the user selected them
                            matching: .images // filter the photos library to only show images
                        ) {
                            // this label changes the text of photo to match either the plural or singular case based on the value in maxPhotosToSelect
                            Text("Chage")
                                .frame(minWidth: 100, minHeight: 50)
                                .background(Color.lemonGreen)
                                .clipShape(.rect(cornerRadius: 12))
                                .foregroundStyle(Color.lemonWhite)
                                .padding(20)
                        }
                        .onChange(of: selectedPhotos) { _, items in
                            Task {
                                for item in items {
                                    if let imageData = try? await item.loadTransferable(
                                        type: Data.self
                                    ) {
                                        selectedImageData = imageData
                                        user.uiImage = UIImage(data: selectedImageData!)!
                                    }
                                }
                            }
                        }
                    }
                }
                
                Section(header: Text("Name")
                    .font(.custom("Karla-Medium", size: 14))
                    .foregroundStyle(Color.gray)
                    .padding(2)
                ) {
                    TextField("\(appUser.name)", text: $appUser.name)
                        .textFieldStyle(.roundedBorder)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color.lemonWhite))
                        .multilineTextAlignment(.leading)
                }
                
                Section(header: Text("Last name")
                    .font(.custom("Karla-Medium", size: 14))
                    .foregroundStyle(Color.gray)
                    .padding(2)
                ) {
                    TextField("\(appUser.lastName)", text: $appUser.lastName)
                        .textFieldStyle(.roundedBorder)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color.lemonWhite))
                        .multilineTextAlignment(.leading)
                }
                
                Section(header: Text("Email")
                    .font(.custom("Karla-Medium", size: 14))
                    .foregroundStyle(Color.gray)
                    .padding(2)
                ) {
                    TextField("\(appUser.email)", text: $appUser.email)
                        .textFieldStyle(.roundedBorder)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color.lemonWhite))
                        .multilineTextAlignment(.leading)
                        .keyboardType(.emailAddress)
                }
                
                Section(header: Text("Phone number Ex: 000-000-0000")
                    .font(.custom("Karla-Medium", size: 14))
                    .foregroundStyle(Color.gray)
                    .padding(2)
                ) {
                    TextField("\(appUser.phoneNumber)", text: $appUser.phoneNumber)
                        .textFieldStyle(.roundedBorder)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color.lemonWhite))
                        .multilineTextAlignment(.leading)
                        .keyboardType(.phonePad)
                }
                
                Text("Email notifications")
                    .font(.custom("Karla-Bold", size: 21))
                    .foregroundStyle(Color.lemonDark)
                    .padding(.top)
                
                Toggle("Order statuses", isOn: $appUser.notifications.orderStatus)
                    .toggleStyle(checkBoxStyle())
                    .padding(10)
                    .onTapGesture {
                        appUser.notifications.orderStatus.toggle()
                    }
                
                Toggle("Password changes", isOn: $appUser.notifications.paswordChage)
                    .toggleStyle(checkBoxStyle())
                    .padding(10)
                    .onTapGesture {
                        appUser.notifications.paswordChage.toggle()
                    }
                
                Toggle("Special offers", isOn: $appUser.notifications.specialOffers)
                    .toggleStyle(checkBoxStyle())
                    .padding(10)
                    .onTapGesture {
                        appUser.notifications.specialOffers.toggle()
                    }
                
                Toggle("Newsletter", isOn: $appUser.notifications.newsLetter)
                    .toggleStyle(checkBoxStyle())
                    .padding(10)
                    .onTapGesture {
                        appUser.notifications.newsLetter.toggle()
                    }
                
                Spacer()
                Button("Log Out") {
                    logOutClicked()
                }
                .font(.custom("Karla-Bold", size: 16))
                .frame(maxWidth: .infinity, maxHeight: 15)
                .padding()
                .foregroundStyle(Color.lemonDark)
                .background(Color(Color.lemonYellow))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.top)
                
                HStack {
                    Button {
                        setAppUser()
                    } label: {
                        Text("Discard changes")
                            .frame(minWidth: 120, maxHeight: 20)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.lemonGreen, lineWidth: 2)
                            )
                            
                    }
                    .font(.custom("Karla-Medium", size: 14))
                    .padding()
                    .foregroundStyle(Color.gray)
                    
                    Button {
                        UserDefaults.standard.set(appUser.name, forKey: kFirstName)
                        UserDefaults.standard.set(appUser.lastName, forKey: kLastName)
                        
                        if isValidEmail(appUser.email) {
                            UserDefaults.standard.set(appUser.email, forKey: kEmail)
                        } else {
                            showAlert = true
                            alertMesage = "Incorectly formated email: \(appUser.email)."
                        }
                        
                        if validate(value: appUser.phoneNumber) {
                            UserDefaults.standard.set(appUser.phoneNumber, forKey: kPhoneNumber)
                        } else {
                            showAlert = true
                            alertMesage = "Invalid phone number."
                        }
                        saveEmailNotifications()
                        saveUserImage()
                    } label: {
                        Text("Save changes")
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.lemonGreen, lineWidth: 2)
                            )
                    }
                    .font(.custom("Karla-Medium", size: 14))
                    .frame(minWidth: 120, maxHeight: 20)
                    .padding()
                    .foregroundStyle(Color.lemonWhite)
                    .background(Color(Color.lemonGreen))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.top)
                
            }
            .padding()
            .onAppear() {
                setAppUser()
            }
            .alert(isPresented: self.$showAlert) {
                Alert(title: Text("\(alertMesage)"))
            }
        }
        .toolbar(true ? .visible : .hidden, for: .tabBar)
    }
        
    
    func logOutClicked() {
        UserDefaults.standard.removeObject(forKey: kFirstName)
        UserDefaults.standard.removeObject(forKey: kLastName)
        UserDefaults.standard.removeObject(forKey: kEmail)
        UserDefaults.standard.removeObject(forKey: kPhoneNumber)
        UserDefaults.standard.removeObject(forKey: kNotifications)
        UserDefaults.standard.removeObject(forKey: kIsLoggedIn)
        navigationPath.path.removeLast()
    }
    
    func validate(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: value)
        return result
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func setAppUser() {
        do {
            let notif: EmailNotifications
            let data = UserDefaults.standard.data(forKey: kNotifications)
            if data != nil {
                let decoder = JSONDecoder()
                notif = try decoder.decode(EmailNotifications.self, from: data!)
            } else {
                notif = EmailNotifications(orderStatus: true, paswordChage: true, specialOffers: true, newsLetter: true)
            }
            
            let img: CustomImage
            let img_data = UserDefaults.standard.data(forKey: kImageName)
            if img_data != nil {
                user.uiImage = UIImage(data: img_data!)!
            }
//            if img_data != nil {
//                let decoder = JSONDecoder()
//                img = try decoder.decode(CustomImage.self, from: img_data!)
//                user.uiImage = img.getImage() ?? user.uiImage
//            }
            
            appUser = User(
                name: UserDefaults.standard.string(forKey: kFirstName) ?? "",
                lastName: UserDefaults.standard.string(forKey: kLastName) ?? "",
                email:  UserDefaults.standard.string(forKey: kEmail) ?? "",
                phoneNumber: UserDefaults.standard.string(forKey: kPhoneNumber) ?? "",
                notifications: notif
            )
        } catch {
            print("Error: \(error)")
        }
    }
    
    func saveEmailNotifications() {
        do {
            let notif = appUser.notifications
            let encoder = JSONEncoder()
            let data = try encoder.encode(notif)
            UserDefaults.standard.set(data, forKey: kNotifications)
        } catch {
            print("Error: \(error)")
        }
    }
    
    func saveUserImage() {
        do {
//            let img = CustomImage(withImage: user.uiImage)
//            let encoder = JSONEncoder()
//            let data = try encoder.encode(img)
            UserDefaults.standard.set(selectedImageData, forKey: kImageName)
        } catch {
            print("Error: \(error)")
        }
    }
}

struct CustomImage: Codable {
    let imageData: Data?
    
    init(withImage image: UIImage) {
        self.imageData = image.pngData()
    }
    func getImage() -> UIImage? {
        guard let imageData = self.imageData else {
            return nil
        }
        let image = UIImage(data: imageData)
        
        return image
    }
}

struct checkBoxStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 21, height: 21)
                .foregroundStyle(Color.lemonGreen)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            configuration.label
        }
    }
}


#Preview {
    @Previewable @State var im = UserImage()
    UserProfileView(user: $im)
        .environment(Path())
}
