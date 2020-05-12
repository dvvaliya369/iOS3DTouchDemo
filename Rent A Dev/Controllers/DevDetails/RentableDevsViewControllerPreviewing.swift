//
//  RentableDevsViewControllerPreviewing.swift
//  Rent A Dev
//
//  Created by Dharmendra Valiya on 05/10/20.
//  Copyright © 2020 Dharmendra Valiya. All rights reserved.
//

import Foundation
import UIKit

extension RentableDevsViewController : UIViewControllerPreviewingDelegate
{
    /// Create a previewing view controller to be shown at "Peek".
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = tableView.indexPathForRow(at: location), let cell = tableView.cellForRow(at: indexPath) else
        {
            return nil
        }
        
        // Create a detail view controller and set its properties.
        let devDetailViewController = storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DeveloperDetailViewController
        
        let dev = developers[(indexPath as NSIndexPath).row]
        devDetailViewController.developer = dev
        
        // Set the source rect to the cell frame, so surrounding elements are blurred.
        previewingContext.sourceRect = cell.frame
        
        return devDetailViewController
    }
    
    /// Present the view controller for the "Pop" action.
    @objc(previewingContext:commitViewController:) func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController)
    {
        // Reuse the "Peek" view controller for presentation.
        show(viewControllerToCommit, sender: self)
    }
}
