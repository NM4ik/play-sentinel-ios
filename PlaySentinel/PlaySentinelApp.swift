//
//  PlaySentinelApp.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 20.03.2024.
//

import SwiftUI
import FirebaseCore

@main
struct PlaySentinelApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                RootView()
            }
        }
    }
}

class AppDelegate : NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("Configuried Firebase!")
        
        return true
    }
}
