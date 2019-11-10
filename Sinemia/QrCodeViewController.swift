//
//  QrCodeViewController.swift
//  Sinemia
//
//  Created by EceOzturk on 23.01.2019.
//  Copyright © 2019 EceOzturk. All rights reserved.
//

import UIKit

class QrCodeViewController: UIViewController {

    @IBOutlet weak var qrCodeImage: UIImageView!
    @IBOutlet var label: UILabel!
    
    @IBOutlet var labelKalanHak: UILabel!
    
    let name = UserInformation.sharedUser.userName
    let UserDb = DBUtil.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.numberOfLines = 2
        print(UserInformation.sharedUser.userName)
        
        do {
            let pakets = try DBUtil.sharedInstance.db!.prepare(UserDb.paket)
            for paket in pakets{
                if UserInformation.sharedUser.userId == paket[UserDb.UserId]
                {
                    for paket in try DBUtil.sharedInstance.db!.prepare(UserDb.paket.select(UserDb.paketId,UserDb.paketName,UserDb.userSurname,
                                                                                         UserDb.paketHak)) {
                                                                                            
                    print("id: \(paket[UserDb.paketId])")
                    Paketler.sharedPaket.paketId = paket[UserDb.paketId]
                    Paketler.sharedPaket.paketName = paket[UserDb.paketName]
                    Paketler.sharedPaket.paketHak = paket[UserDb.paketHak]
                    
                                                                                                
                                                                                            
                    }
                    print("tebrikler!")
                }
                else{
                    print("Hatalı")
                }
            }
            
        }
        catch  {
            print(error)
        }
        createQrCode()
    }
    
    
    func createQrCode()
    {
        
        //let data = UserInformation.sharedUser.userName.data(using: String.Encoding.ascii)
        let data = String(Paketler.sharedPaket.paketHak).data(using: String.Encoding.ascii)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
       let transform = CGAffineTransform(scaleX: 3, y: 3)
        
        if let output = filter?.outputImage?.transformed(by: transform) {
            print(output)
            let image = UIImage(ciImage: output)
            qrCodeImage.image = image
        }
        label.text = "Kullanılan Paket :  \(Paketler.sharedPaket.paketName)  "
        labelKalanHak.text = "Kalan Kullanım Hakkı : \(Paketler.sharedPaket.paketHak) "
    }
    

  

}
