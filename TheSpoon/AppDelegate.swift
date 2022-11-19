//
//  AppDelegate.swift
//  TheSpoon
//
//  Created by Alberto Lagos on 14-11-22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navController = UINavigationController(rootViewController: SPNRestaurantListViewController(dependencies: SPNRestaurantListDependencyContainer()))
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        return true
    }
}

