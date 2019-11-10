//
//  ThirdViewController.swift
//  Sinemia
//
//  Created by EceOzturk on 21.01.2019.
//  Copyright © 2019 EceOzturk. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    var sideMenuOpen = false
    
    @IBOutlet weak var sideMenuConstraint : NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(toggleSideMenu), name: NSNotification.Name("a"), object: nil)
    }
    
    @objc func toggleSideMenu(){
        if sideMenuOpen{
            sideMenuOpen = false
            sideMenuConstraint.constant = -240
        }
        else{
            sideMenuOpen = true
            sideMenuConstraint.constant = 0
        }
    }

   

}
