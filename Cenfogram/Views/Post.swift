//
//  Add.swift
//  Cenfogram
//
//  Created by Estudiantes on 4/16/21.
//

import SwiftUI

struct Post: View {
    
    @State private var postImage: Image?
    @State private var pickedImage: Image?
    @State private var showActionSheet = false
    @State private var showingImagePicker = false
    @State private var imageData: Data = Data()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var showingAlert = false
    @State private var alertTitle: String = "Alert"
    @State private var error: String = ""
    @State private var text = ""
    
    func loadImage(){
        guard let inputImage = pickedImage
            else { return }
        postImage = inputImage
    }
    
    func uploadPost(){
        if let error = errorCheck(){
            self.error = error
            self.showingAlert = true
            return
        }
        
        PostService.uploadPost(caption: text, imageData: imageData, onSuccess: {
            self.clear()
        }) {
            (errorMessage) in
            self.error = errorMessage
            self.showingAlert = true
            return
        }
        /*AuthService.signUp(username: userName, email: email, password: password, imageData: imageData,
                           onSuccess: { (user) in
                            self.clear()
                           }, onError: {
                            (errorMessage) in
                            print("Error \(errorMessage)")
                            self.error = errorMessage
                            self.showingAlert = true
                            return
                           })*/
    }
    
    func clear(){
        self.text = ""
     
        self.imageData = Data()
        self.postImage = Image(systemName: "photo.fill")
        
    }
    
    func errorCheck() -> String? {
        if text.trimmingCharacters(in: .whitespaces).isEmpty
            || imageData.isEmpty
        { return "Agrega una descripcion a la imagen" }
        return nil
    }
    
    var body: some View {
        VStack{
            Text("Postear").font(.largeTitle)
            VStack{
                if postImage != nil {
                    postImage!.resizable()
                        .frame(width: 300, height: 300)
                        .onTapGesture {
                            self.showActionSheet = true
                        }
                } else {
                    Image(systemName: "photo.fill").resizable()
                        .frame(width: 300, height: 300)
                        .onTapGesture {
                            self.showActionSheet = true
                        }
                }
            }
            TextEditor(text: $text)
                .frame(height: 200)
                .padding(4)
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.black))
                .padding(.horizontal)
            
            Button(action: uploadPost){
                Text("Upload Post").font(.title).modifier(ButtonModifiers())
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("Ok")))}
        }.padding()
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
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
    }
}

