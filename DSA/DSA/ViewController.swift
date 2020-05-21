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
        
        test2(["my name is nishit", "my brother name is nishant"])
    }
    
    func test2(_ logLines : [String]) -> [String] {
        var intItems = [String]()
        var stringItems = [String]()
        
        for str in logLines {
            let wordList = str.caseInSensitiveWordsFromSentence()
            if wordList.count > 1 {
                let x = wordList[1]
                if let _ = Int(x) {
                    intItems.append(str)
                }
                else {
                    stringItems.append(str)
                }
            }
        }
        
        var testWordList = [Test2WordItem]()
        
        for item in stringItems {
            let wordList = item.components(separatedBy: CharacterSet(charactersIn: " "))
            if wordList.count > 1 {
                var x = ""
                for index in 1..<wordList.count {
                    x += wordList[index] + " "
                }
                x = x.trimmingCharacters(in: CharacterSet(charactersIn: " "))
                let y = Test2WordItem(val: x, key: wordList[0])
                testWordList.append(y)
            }
        }
        
        let sortedList = testWordList.sorted()
        var finalStringList = [String]()
        for item in sortedList {
            finalStringList.append(item.key + " " + item.value)
        }
        
        var finalList = [String]()
        
        finalList.append(contentsOf: finalStringList)
        finalList.append(contentsOf: intItems)
        return finalList
    }
    
    
    
    func findTopFrequentlyUsedKeywords(_ list : [String], _ keywords : [String], _ target : Int) -> [String] {
            var result = [String]()
            
            if list.isEmpty {
                return result
            }
                    
            var keyWordList = [TestWordItem]()
            for val in keywords {
                let item = TestWordItem(val: val)
                keyWordList.append(item)
            }
            
            for val in keyWordList {
                for str in list {
                    let wordList = str.components(separatedBy: CharacterSet(charactersIn: " "))
                    if wordList.contains(val.value) {
                        val.frequency = val.frequency + 1
                    }
                }
            }
        
        keyWordList = keyWordList.sorted()
            
            let heap = Heap<TestWordItem>(type: .maxHeap, list: keyWordList)
            
            if target < list.count {
                for _ in 0..<target {
                    if let val = heap.extract() {
                        result.append(val.value)
                    }
                }
            }
            else {
                for index in 0..<keyWordList.count {
                    let x = keyWordList[index]
                    result.append(x.value)
                }
            }
            
            return result
        }
        
        
    func popularNToys(numToys:Int,topToys:Int,
                      toys:[String], numQuotes:Int,
                      quotes:[String])->[String]
    {
        // WRITE YOUR CODE HERE
        
        let result = findTopFrequentlyUsedKeywords(quotes, toys, topToys)
        return result
    }
    
    func test() {
        let x = popularNToys(numToys: 5, topToys: 2, toys: ["anacell", "betacellular", "cetracullar", "deltacellular", "eurocell"], numQuotes: 3, quotes: ["best service by anacell", "betacellular has great", "anacell provides best service"])
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
    
    func findIslands() {
        var list = [[1, 1, 0, 0, 0],
                    [0, 1, 0, 0, 1],
                    [1, 0, 0, 1, 1],
                    [0, 0, 0, 0, 0],
                    [1, 0, 1, 0, 1]]
        var result = 0
        Algorithms.findNumberOfIslands(mat: &list, result: &result)
    }
    
    func updateState(_ states : [Int], _ days: Int, _ toggle : inout [Int], _ result : inout [Int]) {
        
        for index in 0..<toggle.count {
            if toggle[index] != -1 {
                result[index] = toggle[index]
            }
        }
        
        if days <= 0 {
            return
        }
        
        if states[0] == 1 && states[states.count-1] == 0 {
            toggle[0] = 0
            toggle[states.count-1] = states[states.count-1]
        }
        else if states[0] == 0 && states[states.count-1] == 1 {
            toggle[states.count-1] = 0
            toggle[0] = states[0]
        }
        
        for index in 1..<states.count-1 {
        if (states[index - 1] == 0 && states[index + 1] == 0) {
                    toggle[index] = 0
        }
        else if (states[index - 1] == 1 && states[index + 1] == 1) {
            toggle[index] = 0
        }
        else if (states[index - 1] == 1 && states[index + 1] == 0) {
                    toggle[index] = 1
        }
        else if (states[index - 1] == 0 && states[index + 1] == 1) {
            toggle[index] = 1
        }
            
        }
        
        updateState(states, days - 1, &toggle, &result)
    }

    func cellCompete(states:[Int], days:Int) -> [Int]
    {
        // WRITE YOUR CODE HERE
        var result = [Int]()

        if states.isEmpty {
            return result
        }
        
        var toggle = [Int]()
        for _ in states {
            toggle.append(-1)
        }
        
        for item in states {
            result.append(item)
        }
        
        updateState(states, days, &toggle, &result)
        return result
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
   
class TestWordItem {
    var frequency = 0
    let value : String
    init(val : String) {
        value = val
    }
}

extension TestWordItem : Comparable {
    static func < (lhs: TestWordItem, rhs: TestWordItem) -> Bool {
        lhs.frequency < rhs.frequency
    }
    
    static func == (lhs: TestWordItem, rhs: TestWordItem) -> Bool {
        return lhs.frequency == rhs.frequency
    }
}


class Test2WordItem {
    let key : String
    let value : String
    init(val : String, key : String) {
        value = val
        self.key = key
    }
}

extension Test2WordItem : Comparable {
    static func < (lhs: Test2WordItem, rhs: Test2WordItem) -> Bool {
        lhs.value < rhs.value
    }
    
    static func == (lhs: Test2WordItem, rhs: Test2WordItem) -> Bool {
        return lhs.value == rhs.value
    }
}


