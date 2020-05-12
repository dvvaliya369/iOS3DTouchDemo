//
//  DeveloperDetailPreviewActions.swift
//  Rent A Dev
//
//  Created by Dharmendra Valiya on 05/12/20.
//  Copyright © 2020 Dharmendra Valiya All rights reserved.
//

import Foundation
import UIKit

extension DeveloperDetailViewController
{
    //MARK: Previewaction Override
    override var previewActionItems : [UIPreviewActionItem]
    {
        //Contact Group
        let contactActionGroup = UIPreviewActionGroup(title: "Contact " + developerFirstName(), style: .default, actions: [contactViaCallDevActionItem(), contactViaEmailDevActionItem(), contactViaMessageDevActionItem()])
        
        return [contactActionGroup, toggleFavoriteStatusActionItem()]
    }
    
    //MARK: Action Setup
    fileprivate func developerFirstName() -> String
    {
        return developer.name.map(String.init).first!
    }
    
    fileprivate func toggleFavoriteStatusActionItem() -> UIPreviewAction
    {
        let title = developer.isFavorite ? "Remove from Favorites" : "Add to Favorites"
        let style : UIPreviewAction.Style = developer.isFavorite ? .destructive : .default
        return UIPreviewAction(title: title, style: style, handler:  { previewAction, viewController in
            self.developer.isFavorite = !self.developer.isFavorite
            DevDataManager.saveDeveloper(self.developer)
        })
    }
    
    fileprivate func contactViaEmailDevActionItem() -> UIPreviewAction
    {
        return UIPreviewAction(title: "Email \(developer.name)", style: .default, handler:  { previewAction, viewController in
            self.contactDeveloper(via: .Email)
        })
    }
    
    fileprivate func contactViaMessageDevActionItem() -> UIPreviewAction
    {
        return UIPreviewAction(title: "Message \(developer.name)", style: .default, handler:  { previewAction, viewController in
            self.contactDeveloper(via: .Message)
        })
    }
    
    fileprivate func contactViaCallDevActionItem() -> UIPreviewAction
    {
        return UIPreviewAction(title: "Call \(developer.name)", style: .default, handler:  { previewAction, viewController in
            self.contactDeveloper(via: .Call)
        })
    }

}
