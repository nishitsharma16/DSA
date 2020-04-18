//
//  ViewController.swift
//  DSA
//
//  Created by Nishit on 06/04/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    var imageView : UIImageView!
//    var observer : NSKeyValueObservation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        observer = imageView.observe(\.image, changeHandler: { (observed, change) in
//
//        })
        
//        NotificationCenter.default.post(name: .BLDownloadImage, object: self, userInfo: ["imageView": "" , "coverUrl" : ""])
        // Do any additional setup after loading the view.
        
//        NotificationCenter.default.addObserver(self, selector: #selector(downloadImage()), name: .BLDownloadImage, object: nil)
    }
    
    func doThis(imageRef : ImageRef) {
        
//        imageRef = ImageRef()
    }
    
    deinit {
    }
//    @objc func downloadImage() {
//
//    }
    
//    override func encodeRestorableState(with coder: NSCoder) {
//      super.encodeRestorableState(with: coder)
//    }
//
//    override func decodeRestorableState(with coder: NSCoder) {
//      super.decodeRestorableState(with: coder)
//    }
}


extension Notification.Name {
  static let BLDownloadImage = Notification.Name("BLDownloadImageNotification")
}


class ImageRef {
    
}
