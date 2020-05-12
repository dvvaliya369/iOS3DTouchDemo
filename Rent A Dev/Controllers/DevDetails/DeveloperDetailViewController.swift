
//
//  DeveloperDetailViewController.swift
//  Rent A Dev
//
//  Created by Dharmendra Valiya on 05/12/20.
//  Copyright © 2020 Dharmendra Valiya All rights reserved.
//

import UIKit

enum ContactOptions : String
{
    case Email = "Email"
    case Message = "Message"
    case Call = "Call"
}

class DeveloperDetailViewController: UIViewController
{

    //MARK: Properties
    var developer:Developer!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var backgroundAvatarImageView: UIImageView!
    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet weak var distanceFromLabel: UILabel!
    @IBOutlet weak var hourlyRateLabel: UILabel!
    @IBOutlet weak var expertiseTopLabel: UILabel!
    @IBOutlet weak var expertiseStackView: UIStackView!
    @IBOutlet weak var favoriteBarButtonItem: UIBarButtonItem!
    
    //MARK: View Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Set developer's image and name
        backgroundAvatarImageView.image = developer.avatarImg
        avatarImageView.image = developer.avatarImg
        navigationItem.title = developer.name
        
        //Set a random distance from and hourly rate
        distanceFromLabel.text = String((Int(arc4random_uniform(UInt32(10 - 1))) + 10)) + " miles away from you"
        hourlyRateLabel.text = "Charges $" + String((Int(arc4random_uniform(UInt32(150 - 1))) + 150)) + " an hour"
        
        //Set the developer's experise
        addExpertiseBubblesToView()
        
        setFavoritesButtonTitle()
        
        //Assign to quick actions
        ShortcutItemHelper.createShortcutItem(with :developer)
    }
    
    @IBAction func addToFavorites(_ sender: UIBarButtonItem)
    {
        developer.isFavorite = !developer.isFavorite
        DevDataManager.saveDeveloper(developer)
        setFavoritesButtonTitle()
    }
    
    
    @IBAction func presentContactOptions(_ sender: UIBarButtonItem)
    {
        let actionSheet = UIAlertController(title: "Contact \(developer.name)", message: "", preferredStyle: .actionSheet)
        
        let callAction = UIAlertAction(title: "Call", style: .default) { action in
            self.contactDeveloper(via: .Call)
        }
        actionSheet.addAction(callAction)
        
        let messageAction = UIAlertAction(title: "Message", style: .default) { action in
            self.contactDeveloper(via: .Message)
        }
        actionSheet.addAction(messageAction)
        
        let emailAction = UIAlertAction(title: "Email", style: .default) { action in
            self.contactDeveloper(via: .Email)
        }
        actionSheet.addAction(emailAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    fileprivate func setFavoritesButtonTitle()
    {
        favoriteBarButtonItem.title = developer.isFavorite ? "Remove as Favorite" : "Add to Favorites"
        favoriteBarButtonItem.tintColor = developer.isFavorite ? UIColor.red : view.tintColor
    }
    
    //MARK: Adding Expertise Functions
    fileprivate func addExpertiseBubblesToView()
    {
        developer.expertiseArray().forEach {
            let expertiseBubble = ExperiseBubbleView(frame: CGRect.zero)
            expertiseBubble.expertiseLabel.text = $0
            expertiseStackView.addArrangedSubview(expertiseBubble)
        }
    }
    
    //MARK: Contact Functions
    func contactDeveloper(via contactOption:ContactOptions)
    {
        guard let rootController = UIApplication.shared.keyWindow?.rootViewController else
        {
            return
        }
        
        var alert:UIAlertController!
        
        switch contactOption
        {
            case .Call:
                alert = showAlertWith(title: "", message: "Calling \(developer.name) 📱")
            case .Email:
                alert = showAlertWith(title: "", message: "Emailing \(developer.name) 💻")
            case .Message:
                alert = showAlertWith(title: "", message: "Messaging \(developer.name) 📝")
        }
        
        rootController.present(alert, animated: true, completion: nil)
    }
}
