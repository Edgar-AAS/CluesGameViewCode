//
//  SceneDelegate.swift
//  Challenge3
//
//  Created by Edgar Arlindo on 20/07/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let controller = CluesViewController()
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
        
    }
}

