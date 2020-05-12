//
//  DataManager.swift
//  Rent A Dev
//
//  Created by Dharmendra Valiya on 05/12/20.
//  Copyright © 2020 Dharmendra Valiya All rights reserved.
//

import Foundation

struct DevDataManager
{
    //MARK: Private properties
    fileprivate static let developerInfoFilePath = Bundle.main.path(forResource: "FakeDevelopersFreshData", ofType: "plist")!
    fileprivate static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    fileprivate static let ArchiveURL = DocumentsDirectory.appendingPathComponent("developers")

    //MARK: Saving and Loading
    static func saveDeveloper(_ developer:Developer)
    {        
        let currentDevs = DevDataManager.loadDevelopers()
        currentDevs.filter{ $0.name == developer.name }.first?.isFavorite = developer.isFavorite
        NSKeyedArchiver.archiveRootObject(currentDevs, toFile: DevDataManager.ArchiveURL.path)
    }
    
    static func loadDevelopers() -> [Developer]
    {
        guard let devs = NSKeyedUnarchiver.unarchiveObject(withFile: DevDataManager.ArchiveURL.path) as? [Developer] else
        {
            return DevDataManager.loadInitialDeveloperData()
        }
        
        return devs
    }
    
    fileprivate static func loadInitialDeveloperData() -> [Developer]
    {
        let devsInfoFilePath = Bundle.main.path(forResource: "FakeDevelopersFreshData", ofType: "plist")!
        var devArray:[Developer] = [Developer]()
        
        for (devName, info) in NSDictionary(contentsOfFile: devsInfoFilePath)!
        {
            let devInfo = info as! NSDictionary
            let sex = devInfo["Sex"] as! NSNumber
            let developerSex = Developer.Sex(rawValue: sex.intValue)
            let expertise = devInfo["Expertise"] as! String
            devArray.append(Developer(userSex: developerSex!, name: devName as! String, expertise: expertise))
        }
        
        return devArray.sorted{ $0.name < $1.name }
    }
}
