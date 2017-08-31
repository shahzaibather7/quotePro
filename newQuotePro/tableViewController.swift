//
//  ViewController.swift
//  newQuotePro
//
//  Created by Mohammad Shahzaib Ather on 2017-08-30.
//  Copyright © 2017 Mohammad Shahzaib Ather. All rights reserved.
//

import UIKit

class tableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCoolNavBar()
      
    }
    
    
    
    
    
    
    
    
    
    
//Housekeeping Methods - Segues / Setting up View Controller
    func addQuote (){
        let viewController = QuoteViewController()
        navigationController?.pushViewController(viewController, animated: true)
        
    }

    func createCoolNavBar(){
        navigationItem.title = "Quote Pro"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image:#imageLiteral(resourceName: "new_message_icon") , style: .plain, target: self, action: #selector(addQuote))
    }
    
}



