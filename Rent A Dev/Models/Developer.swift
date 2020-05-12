//
//  Developer.swift
//  Rent A Dev
//
//  Created by Dharmendra Valiya on 05/12/20.
//  Copyright © 2020 Dharmendra Valiya All rights reserved.
//

import Foundation
import UIKit.UIImage

final class Developer : NSObject, NSCoding
{
    //MARK: Properties
    let userSex:Sex
    let name:String
    let expertise:String
    var isFavorite:Bool
    let avatarImg:UIImage
    
    enum Sex:Int
    {
        case male
        case female
    }
    
    fileprivate struct PropertyKey
    {
        static let userSexKey = "userSex"
        static let nameKey = "name"
        static let expertiseKey = "expertise"
        static let favoriteKey = "isFavorite"
    }
    
    //MARK: Initializers
    init(userSex:Sex, name:String, expertise:String, favorite:Bool = false)
    {
        self.userSex = userSex
        self.name = name
        self.expertise = expertise
        self.isFavorite = favorite
        self.avatarImg = UIImage(named:name.substring(to: name.range(of: " ")!.lowerBound).lowercased())!
        super.init()
    }
    
    //MARK: NSCoding Protocol
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(self.userSex.rawValue, forKey: PropertyKey.userSexKey)
        aCoder.encode(self.name, forKey: PropertyKey.nameKey)
        aCoder.encode(self.expertise, forKey: PropertyKey.expertiseKey)
        aCoder.encode(self.isFavorite, forKey: PropertyKey.favoriteKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder)
    {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as? String,
              let expertise = aDecoder.decodeObject(forKey: PropertyKey.expertiseKey) as? String
              else { return nil }
        
        self.init(userSex: Sex(rawValue: aDecoder.decodeInteger(forKey: PropertyKey.userSexKey))!, name: name, expertise: expertise, favorite: aDecoder.decodeBool(forKey: PropertyKey.favoriteKey))
    }
    
    //MARK: Instance Functions
    func expertiseArray() -> [String]
    {
        return expertise.components(separatedBy: ", ")
    }
}
