//
//  ShortCutItemHelper.swift
//  Rent A Dev
//
//  Created by Dharmendra Valiya on 05/12/20.
//  Copyright © 2020 Dharmendra Valiya All rights reserved.
//

import Foundation
import UIKit

enum IncomingShortcutItem: String
{
    case ShowFavorites
    case ShowDeveloper
    fileprivate static let prefix: String = {
        return Bundle.main.bundleIdentifier! + "."
    }()
    
    init?(shortCutType: String)
    {
        guard let bundleStringRange = shortCutType.range(of: IncomingShortcutItem.prefix) else
        {
            return nil
        }
        
        var enumValueString = shortCutType
        enumValueString.removeSubrange(bundleStringRange)
        self.init(rawValue: enumValueString)
    }
}

struct ShortcutItemHelper
{
    static let profileKey = "devKey"
    
    //MARK: Shortcut creation
    static func createShortcutItem(with developer:Developer)
    {
        //If the developer is already there, skip it
        guard ((UIApplication.shared.shortcutItems?.filter { $0.localizedTitle == developer.name }.count)! <= 0) else
        {
            return
        }
        
        let maxShortcutItemsLimitReached = UIApplication.shared.shortcutItems?.count == 3
        let shortcutIcon = UIApplicationShortcutIcon(type: .contact)
        if #available(iOS 11.0, *) {
            do {
            let shortCutItem =  try UIApplicationShortcutItem(type: IncomingShortcutItem.prefix + "ShowDeveloper", localizedTitle: developer.name, localizedSubtitle: developer.expertise, icon: shortcutIcon, userInfo: [profileKey : NSKeyedArchiver.archivedData(withRootObject: developer, requiringSecureCoding: true)] as [String: NSSecureCoding])
                UIApplication.shared.shortcutItems?.append(shortCutItem)
            }catch {
                
            }
            
        } else {
            // Fallback on earlier versions
        }
        
        if maxShortcutItemsLimitReached
        {
            //Replace the oldest developer
            UIApplication.shared.shortcutItems?.removeFirst()
        }
        
//        UIApplication.shared.shortcutItems?.append(shortCutItem)
    }
    
    //MARK: Shortcut Handling
    
    //Takes in a shortcutitem and decides which one it is and handles it (i.e. Favorites vs Dev Details)
    @discardableResult
    static func handleShortcutItem(_ shortcutItem:UIApplicationShortcutItem) -> Bool
    {
        guard let shortCutAction = IncomingShortcutItem(shortCutType: shortcutItem.type) else
        {
            return false
        }
        
        switch shortCutAction
        {
        case .ShowFavorites:
            //Handle static quick action to show favorites
            return ShortcutItemHelper.handleShortcutActionShowFavorites()
            
        case .ShowDeveloper:
            //Handle dynamic quick action of showing a certain developer
            guard let devData = shortcutItem.userInfo?[ShortcutItemHelper.profileKey] as? Data, let developer = NSKeyedUnarchiver.unarchiveObject(with: devData) as? Developer else
            {
                return false
            }
            
            return ShortcutItemHelper.handleShortcutAction(with: developer)
        }

        
    }
    
    //Handles the favorite shortcut
    static func handleShortcutActionShowFavorites() -> Bool
    {
        guard let rootNavigationViewController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController else
        {
            return false
        }
        
        rootNavigationViewController.popToRootViewController(animated: false)
        
        guard let developersViewController = rootNavigationViewController.topViewController as? RentableDevsViewController else
        {
            return false
        }
        
        developersViewController.showFavoriteDevelopers()
        
        return true
    }

    //Handles the developer details shortcut
    static func handleShortcutAction(with developer:Developer) -> Bool
    {
        guard let rootNavigationViewController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController else
        {
            return false
        }
        
        let appStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let devDetailViewController = appStoryboard.instantiateViewController(withIdentifier: "DetailViewController") as? DeveloperDetailViewController else
        {
            return false
        }
        
        rootNavigationViewController.popToRootViewController(animated: false)
        devDetailViewController.developer = developer
        rootNavigationViewController.pushViewController(devDetailViewController, animated: false)
        
        return true
    }
}
