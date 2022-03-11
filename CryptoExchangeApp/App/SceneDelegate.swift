//
//  SceneDelegate.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 08/03/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let navigationController = UINavigationController()
        let appCoordinator = AppCoordinator(navigationController: navigationController)
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController
        
        appCoordinator.start()
    }
}
