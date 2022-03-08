//
//  AppDelegate.swift
//  DestinationList
//
//  Created by Erik Nascimento on 05/03/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let navigationController = UINavigationController()
        let vm = DestinationViewModel()
        let viewcontroller = ViewController(viewModel: vm, coordinator: DestinationsCoordinator(navigationController: navigationController))
        navigationController.setViewControllers([viewcontroller], animated: true)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

