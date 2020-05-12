//
//  FakeDataLoader.swift
//  Rent A Dev
//
//  Created by Dharmendra Valiya on 05/12/20.
//  Copyright © 2020 Dharmendra Valiya All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    func beginFakeDataLoad(_ completion:@escaping () -> ())
    {
        let fakeActivity = UIActivityIndicatorView(style: .gray)
        let loadingLabel = UILabel()
        
        fakeActivity.translatesAutoresizingMaskIntoConstraints = false
        fakeActivity.startAnimating()
        view.addSubview(fakeActivity)
        fakeActivity.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fakeActivity.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        loadingLabel.text = "Finding Nearby Developers..."
        view.addSubview(loadingLabel)
        loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingLabel.topAnchor.constraint(equalTo: fakeActivity.bottomAnchor, constant: 8).isActive = true
        
        let loadingDelay = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: loadingDelay) {
            fakeActivity.stopAnimating()
            fakeActivity.removeFromSuperview()
            loadingLabel.removeFromSuperview()
            
            completion()
        }
    }
}
