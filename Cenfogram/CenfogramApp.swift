//
//  CenfogramApp.swift
//  Cenfogram
//
//  Created by Estudiantes on 4/7/21.
//

import SwiftUI
import Firebase
@main
struct CenfogramApp: App {
    
    @UIApplicationDelegateAdaptor (AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(SessionStore())
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        print("firebase... ")
        FirebaseApp.configure()
        return true
    }
}
