//
//  AppDelegate.swift
//  result-builder-mastering
//
//  Created by taekki on 2023/08/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = SettingViewControlelr(style: .insetGrouped)
    window?.makeKeyAndVisible()
    
    return true
  }

}
