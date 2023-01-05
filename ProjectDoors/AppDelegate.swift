//
//  AppDelegate.swift
//  ProjectDoors
//
//  Created by Artem Manakov on 04.01.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            let vc = DoorsViewController()
            window.rootViewController = vc
            window.makeKeyAndVisible()
        }
        return true
    }

}

