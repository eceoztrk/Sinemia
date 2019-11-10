//
//  MainViewController.swift
//  Sinemia
//
//  Created by EceOzturk on 22.01.2019.
//  Copyright © 2019 EceOzturk. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UIScrollViewDelegate, UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet var button: UIButton!
    @IBOutlet var button3: UIButton!
    
    @IBOutlet weak var pageControl : UIPageControl!
    @IBOutlet weak var scrollView : UIScrollView!
    
    @IBOutlet var label: UILabel!
    
    var image : [String] = ["eee","zzz","fff"]
    var scrollLabel : [String] = ["Aylık Sinema Bileti Üyelikleri","Yıllık Sinema Bileti Üyelikleri","Çift Kişilik Sinema Bileti Üyelikleri"]
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    
   // buttton3.addTarget(self, action: Selector("holdRelease:"), forControlEvents: UIControlEvents.TouchUpInside);
   //button3.addTarget(self, action: Selector("HoldDown:"), forControlEvents: UIControlEvents.TouchDown)
    
    
    //target functions
    @objc func HoldDown(sender:UIButton)
    {
        button3.layer.borderWidth = 2
        button3.layer.borderColor = UIColor.black.cgColor
    }
    
    @objc func holdRelease(sender:UIButton)
    {
        button3.backgroundColor = UIColor.white
    }
    
    var imageArroy = [UIImage(named: "0"),UIImage(named: "1"),UIImage(named: "2"),UIImage(named: "3")]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArroy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.imgImage.image = imageArroy[indexPath.row]
        return cell
    }
    
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(qrCode), name: NSNotification.Name("QrCode"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(goProfile), name: NSNotification.Name("GoToProfile"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(goLogin), name: NSNotification.Name("GoToLogin"), object: nil)
        
        //button3.addTarget(self, action: Selector("holdRelease:"), forControlEvents: UIControl.Event.touchUpInside)
        //button3.addTarget(self, action: Selector("HoldDown:"), forControlEvents: UIControl.Event.touchDown)
        
        button3.addTarget(self, action: #selector(HoldDown(sender:)), for: UIControl.Event.touchUpInside)
        //button3.addTarget(self, action: #selector(holdRelease(sender:)), for: UIControl.Event.touchDown)
        
        //button.titleLabel?.numberOfLines = 2
        //button.titleLabel?.textAlignment = .center
        
        imageScrollView()
    }
    @objc func qrCode(){
        performSegue(withIdentifier: "goToQrCode", sender: self)
        
    }
    @objc func goProfile(){
        performSegue(withIdentifier: "goToProfile", sender: self)
    }
    @objc func goLogin(){
        performSegue(withIdentifier: "goToLogin", sender: self)
    }

    @IBAction func onMoreTapped(){
        print("TOGGLE SIDE MENU")
        NotificationCenter.default.post(name: NSNotification.Name("a"), object: nil)
    }

    func imageScrollView()
    {
        pageControl.numberOfPages = image.count
        
        for index in 0..<image.count{
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            
            let imgView = UIImageView(frame: frame)
            imgView .image = UIImage(named: image[index])
            //label.text =  scrollLabel[index]
            self.scrollView.addSubview(imgView)
            //self.scrollView.addSubview(label)
            
        }
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(image.count)), height: scrollView.frame.size.height)
        scrollView.delegate = self
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        var pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor.black
    }
}
