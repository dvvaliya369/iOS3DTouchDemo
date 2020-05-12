//
//  AppDelegate.swift
//  Rent A Dev
//
//  Created by Dharmendra Valiya on 05/12/20.
//  Copyright © 2020 Dharmendra Valiya All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    //MARK: Properties
    var window: UIWindow?
    
    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        if let shortcutItem = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem
        {
            ShortcutItemHelper.handleShortcutItem(shortcutItem)
            return false
        }
        
        return true
    }
    
    //MARK: 3D Touch Shortcut Handling
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void)
    {
        completionHandler(ShortcutItemHelper.handleShortcutItem(shortcutItem))
    }
}
