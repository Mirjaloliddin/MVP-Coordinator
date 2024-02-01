//
//  AppDelegate.swift
//  Nothing
//
//  Created by Murtazaev Mirjaloliddin Kamolovich on 09/01/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private var launchManager: AppLaunchManager!
    var window: UIWindow?
    var windowRouter: WindowRouter!
    var composer: AppComposer!
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        composer = AppComposer(
            window: UIWindow(frame: UIScreen.main.bounds)
        )
        launchManager = composer.compose()
        
        launchManager.start(with: application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
    
}

