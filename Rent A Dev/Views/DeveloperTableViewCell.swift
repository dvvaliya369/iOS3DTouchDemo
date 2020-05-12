//
//  DeveloperTableViewCell.swift
//  Rent A Dev
//
//  Created by Dharmendra Valiya on 05/12/20.
//  Copyright © 2020 Dharmendra Valiya All rights reserved.
//

import UIKit

class DeveloperTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var expertiseLabel: UILabel!
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        avatarImageView.contentMode = UIView.ContentMode.scaleAspectFit
        avatarImageView.clipsToBounds = true
    }
    
    func bindData(with developer:Developer)
    {
        avatarImageView.image = developer.avatarImg
        nameLabel.text = developer.name
        expertiseLabel.text = developer.expertise
    }

}
