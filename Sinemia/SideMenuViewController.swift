//
//  SideMenuViewController.swift
//  Sinemia
//
//  Created by EceOzturk on 22.01.2019.
//  Copyright © 2019 EceOzturk. All rights reserved.
//

import UIKit

class SideMenuViewController: UITableViewController {

    @IBOutlet var nameLabel: UILabel!
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        NotificationCenter.default.post(name: NSNotification.Name("a"), object: nil)
        switch indexPath.row {
        case 1:
            NotificationCenter.default.post(name: NSNotification.Name("QrCode"), object: nil)
        case 2:
            NotificationCenter.default.post(name: NSNotification.Name("GoToProfile"), object : nil)
            
        case 4:
            NotificationCenter.default.post(name: NSNotification.Name("GoToLogin"), object : nil)
        default:
            break
        }
        
      
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.backgroundColor = UIColor.lightGray
        //tableView.backgroundView = UIImageView(image: UIImage(named: "more.png"))
       tableView.backgroundColor = UIColor.white
        
        nameLabel.text = UserInformation.sharedUser.userName
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
   override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.backgroundColor = UIColor.white
    
    
    }
}
