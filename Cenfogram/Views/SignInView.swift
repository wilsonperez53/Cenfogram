//
//  SignInView.swift
//  Cenfogram
//
//  Created by Estudiantes on 4/7/21.
//

import SwiftUI

struct SignInView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Alert"
    @State private var error: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20){
                Image(systemName: "camera").font(.system(size: 60, weight: .black, design: .monospaced))
                
                VStack(alignment: .leading){
                    Text("Bienvenido a Cenfogram").font(.system(size: 32, weight: .heavy))
                    Text("Ingresar").font(.system(size: 16, weight: .medium))
                }
                    FormField(value: $email, icon: "envelope.fill", placeHolder: "Email")
                    
                    FormField(value: $password          , icon: "lock.fill",
                              isSecure: true, placeHolder: "Password")
                    Button(action: signIn) {
                        /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/.font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .modifier(ButtonModifiers())
                    }.alert(isPresented: $showingAlert) {
                        Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("Ok")))
                    }
                HStack{
                    Text("New?")
                    NavigationLink(
                        destination: SignUpView(),
                        label: {
                            Text("Create an account").font(.system(size: 20, weight: .semibold))
                        })
                        .foregroundColor(.black)
                        
                    
                }
            }.padding()
        }
    }
    func errorCheck() -> String? {
        if email.trimmingCharacters(in: .whitespaces).isEmpty || password.trimmingCharacters(in: .whitespaces).isEmpty
            
        { return "Please complete the data" }
        return nil
    }
    
    func clear(){
        self.email = ""
        self.password = ""
    }
    func signIn(){
        if let error = errorCheck(){
            self.error = error
            self.showingAlert = true
            return
        }
        
        AuthService.signIn(email: email, password: password, 
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
}

