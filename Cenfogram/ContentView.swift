//
//  ContentView.swift
//  Cenfogram
//
//  Created by Estudiantes on 4/7/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var session: SessionStore
    @State private var mail = ""
    @State private var password = ""
    
    func listen(){
        session.listen()
    }
    var body: some View {
        
        Group{
            if(session.session != nil){
                HomeView()
            } else {
                SignInView()
            }
        }.onAppear(perform: listen)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
