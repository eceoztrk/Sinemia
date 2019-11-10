//
//  PaketViewController.swift
//  Sinemia
//
//  Created by EceOzturk on 1.02.2019.
//  Copyright © 2019 EceOzturk. All rights reserved.
//

import UIKit

class PaketViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    var imageArroy = [UIImage(named: "eee"),UIImage(named: "zzz"),UIImage(named: "fff")]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArroy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaketCollectionViewCell", for: indexPath) as! PaketCollectionViewCell
        cell.paketImage.image = imageArroy[indexPath.row]
        return cell
    }
}
