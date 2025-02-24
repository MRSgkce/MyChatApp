//
//  AppDelegate.swift
//  MyChatApp
//
//  Created by Mürşide Gökçe on 15.02.2025.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
       window = UIWindow()
        window?.rootViewController = UINavigationController(rootViewController: HomeViewController())
        window?.makeKeyAndVisible()
        
        
        return true
    }
    
   

    // MARK: UISceneSession Lifecycle

   


}

