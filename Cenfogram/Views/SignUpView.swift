//
//  SignUpView.swift
//  Cenfogram
//
//  Created by Estudiantes on 4/7/21.
//

import SwiftUI

struct SignUpView: View {
    @State private var userName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var profileImage: Image?
    @State private var pickedImage: Image?
    @State private var showActionSheet = false
    @State private var showingImagePicker = false
    @State private var imageData: Data = Data()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var showingAlert = false
    @State private var alertTitle: String = "Alert"
    @State private var error: String = ""
    
    func loadImage(){
        guard let inputImage = pickedImage
            else { return }
        profileImage = inputImage
    }
    
    func errorCheck() -> String? {
        if email.trimmingCharacters(in: .whitespaces).isEmpty || password.trimmingCharacters(in: .whitespaces).isEmpty
            || userName.trimmingCharacters(in: .whitespaces).isEmpty
            || imageData.isEmpty
        { return "Please complete the data" }
        return nil
    }
    
    func clear(){
        self.email = ""
        self.userName = ""
        self.password = ""
        self.imageData = Data()
        self.profileImage = Image(systemName: "person.circle.fill")
    }
    
    func signUp(){
        if let error = errorCheck(){
            self.error = error
            self.showingAlert = true
            return
        }
        
        AuthService.signUp(username: userName, email: email, password: password, imageData: imageData,
                           onSuccess: { (user) in
                            self.clear()
                           }, onError: {
                            (errorMessage) in
                            print("Error \(errorMessage)")
                            self.error = errorMessage
                            self.showingAlert = true
                            return
                           })
    }
    
    var body: some View {
        ScrollView {
            
        VStack(spacing: 20){
            Image(systemName: "camera").font(.system(size: 60, weight: .black, design: .monospaced))
            
            VStack(alignment: .leading){
                Text("Entrar a Cenfogram").font(.system(size: 32, weight: .heavy))
                Text("Ingresar").font(.system(size: 16, weight: .medium))
            }
            VStack{
                Group{
                    if profileImage != nil {
                        profileImage!.resizable()
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .frame(width: 200, height: 200)
                            .padding(.top, 20)
                            .onTapGesture {
                                self.showActionSheet = true
                            }
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                            .padding(.top,20)
                            .onTapGesture {
                                self.showActionSheet = true
                            }
                    }
                    
                }	
            }
            
            Group{
                FormField(value: $userName, icon: "person.fill", placeHolder: "Username")
          
                FormField(value: $email, icon: "envelope.fill", placeHolder: "Email")
                FormField(value: $password          , icon: "lock.fill",
                          isSecure: true, placeHolder: "Password")
            }
            Button(action: signUp) {
                    Text("Sign Up").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .modifier(ButtonModifiers())
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("Ok")))
            }
        }.padding()
        }.sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(pickedImage: self.$pickedImage, showImagePicker: self.$showingImagePicker, imageData: self.$imageData)
        }.actionSheet(isPresented: $showActionSheet){
            ActionSheet(title: Text(""), message: Text(""), buttons: [.default(Text("Seleccione una foto")){
                self.sourceType =
                    .photoLibrary
                self.showingImagePicker = true
            },
            .default(Text("Take a photo")){
                self.sourceType = .camera
                self.showingImagePicker = true
            },
            .cancel()
            ])
        }
    }// .scrollView
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
