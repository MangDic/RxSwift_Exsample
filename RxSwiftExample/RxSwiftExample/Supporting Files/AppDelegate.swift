//
//  AppDelegate.swift
//  RxSwiftExample
//
//  Created by 이명직 on 2022/06/30.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    static let shared = UINavigationController(rootViewController: MainViewController())

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let window = window else { return false }

        window.rootViewController = AppDelegate.shared
        window.makeKeyAndVisible()
        return true
    }
}

