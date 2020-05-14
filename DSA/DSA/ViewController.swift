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
//    weak var x : ImageRef?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let x = "Nishit"
//        let index = x.endIndex
//        let val = x[x.endIndex]
//        AnyObject
//        observer = imageView.observe(\.image, changeHandler: { (observed, change) in
//
//        })
        
//        NotificationCenter.default.post(name: .BLDownloadImage, object: self, userInfo: ["imageView": "" , "coverUrl" : ""])
        // Do any additional setup after loading the view.
        
//        NotificationCenter.default.addObserver(self, selector: #selector(downloadImage()), name: .BLDownloadImage, object: nil)
        
        findPathToTreasureIland()
    }
    
    func findMinTowers() {
        var list = [[1,0,1],[1,0,1],[1,0,1]]
        var result = 0
        Algorithms.findMinimumTowers(mat: &list, result: &result)
    }
    
    func findMinHoursToConvertToZombie() {
        var list = [[0, 1, 1, 0, 1],
        [0, 1, 0, 1, 0],
        [0, 0, 0, 0, 1],
        [0, 1, 0, 0, 0]]
        var result = 0
        Algorithms.minHoursToConvertIntoZombies(mat: &list, result: &result)
        print(result)
    }
    
    func findPathToTreasureIland() {
        let list = [["O", "O", "O", "O"],
        ["D", "O", "D", "O"],
        ["O", "O", "O", "O"],
        ["X", "D", "D", "O"]]
        let result = Algorithms.shortestPathToFindTreasureIsland(mat:list)
        print(result)

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
    
    init(val : BuildStatus?) {

        switch val {
        case .inProgress:
            print("Build is starting…")
        case .complete:
            print("Build is complete!")
        default:
            print("Some other build status")
        }
    }
}

enum BuildStatus {
    case starting
    case inProgress
    case complete
}

