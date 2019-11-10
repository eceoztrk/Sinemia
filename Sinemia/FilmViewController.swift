//
//  FilmViewController.swift
//  Sinemia
//
//  Created by EceOzturk on 29.01.2019.
//  Copyright © 2019 EceOzturk. All rights reserved.
//

import UIKit

class FilmViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var imageArroy = [UIImage(named: "0"),UIImage(named: "1"),UIImage(named: "2"),UIImage(named: "3")]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArroy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KampanyaCollectionViewCell", for: indexPath) as! KampanyaCollectionViewCell
        cell.imageImage.image = imageArroy[indexPath.row]
        return cell
    }

}
