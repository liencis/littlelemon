//
//  UserProfileView.swift
//  Restaurant
//
//  Created by Liene Zegele on 1/8/26.
//

import SwiftUI
import PhotosUI

struct UserProfileView: View {
    // @Environment(\.presentationMode) var presentation
    @Environment(Path.self) var navigationPath
    @Binding var user: UserImage
    
    var firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    var lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
    var email = UserDefaults.standard.string(forKey: kEmail) ?? ""
    var userImage = UserDefaults.standard.string(forKey: kImageName) ?? ""
    var phoneNumber = UserDefaults.standard.string(forKey: kPhoneNumber) ?? ""
    
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
                    TextField("\(firstName)", text: $appUser.name)
                        .textFieldStyle(.roundedBorder)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color.lemonWhite))
                        .multilineTextAlignment(.leading)
                }
                
                Section(header: Text("Last name")
                    .font(.custom("Karla-Medium", size: 14))
                    .foregroundStyle(Color.gray)
                    .padding(2)
                ) {
                    TextField("\(lastName)", text: $appUser.lastName)
                        .textFieldStyle(.roundedBorder)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color.lemonWhite))
                        .multilineTextAlignment(.leading)
                }
                
                Section(header: Text("Email")
                    .font(.custom("Karla-Medium", size: 14))
                    .foregroundStyle(Color.gray)
                    .padding(2)
                ) {
                    TextField("\(email)", text: $appUser.email)
                        .textFieldStyle(.roundedBorder)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color.lemonWhite))
                        .multilineTextAlignment(.leading)
                        .keyboardType(.emailAddress)
                }
                
                Section(header: Text("Phone number")
                    .font(.custom("Karla-Medium", size: 14))
                    .foregroundStyle(Color.gray)
                    .padding(2)
                ) {
                    TextField("\(phoneNumber)", text: $appUser.phoneNumber)
                        .textFieldStyle(.roundedBorder)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color.lemonWhite))
                        .multilineTextAlignment(.leading)
                        .keyboardType(.phonePad)
                }
                
                Text("Email notifications")
                    .font(.custom("Karla-Bold", size: 21))
                    .foregroundStyle(Color.lemonDark)
                
                Toggle("Order statuses", isOn: $appUser.notifications.orderStatus)
                    .toggleStyle(checkBoxStyle())
                    .padding(10)
                    .onTapGesture {
                        appUser.notifications.orderStatus.toggle()
                    }
                
                Toggle("Password changes", isOn: $appUser.notifications.orderStatus)
                    .toggleStyle(checkBoxStyle())
                    .padding(10)
                    .onTapGesture {
                        appUser.notifications.orderStatus.toggle()
                    }
                
                Toggle("Special offers", isOn: $appUser.notifications.orderStatus)
                    .toggleStyle(checkBoxStyle())
                    .padding(10)
                    .onTapGesture {
                        appUser.notifications.orderStatus.toggle()
                    }
                
                Toggle("Newsletter", isOn: $appUser.notifications.orderStatus)
                    .toggleStyle(checkBoxStyle())
                    .padding(10)
                    .onTapGesture {
                        appUser.notifications.orderStatus.toggle()
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
                        logOutClicked()
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
                        logOutClicked()
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
                
            }.padding()
        }
        .toolbar(true ? .visible : .hidden, for: .tabBar)
    }
        
    
    func logOutClicked() {
        UserDefaults.standard.removeObject(forKey: kFirstName)
        UserDefaults.standard.removeObject(forKey: kLastName)
        UserDefaults.standard.removeObject(forKey: kEmail)
        navigationPath.path.removeLast()
    }
    
    func validate(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: value)
        return result
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
