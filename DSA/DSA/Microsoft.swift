//
//  Microsoft.swift
//  DSA
//
//  Created by Nishit on 14/12/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

extension Problems {

    static func findDuplicates(_ nums: [Int]) -> [Int] {
        if nums.isEmpty {
            return []
        }
        var result = [Int]()
        var map = [Int: Int]()
        for item in nums {
            if let val = map[item] {
                if val == 1 {
                    result.append(item)
                }
                map[item] = val + 1
            }
            else {
                map[item] = 1
            }
        }
        return result
    }
    
}

class ArrayReader {
    public func get(_ index: Int) -> Int {
        return -1
    }
}



class ArrayReaderItemSearch {
    
    static func binarySearchWith(_ reader: ArrayReader, _ low: Int, _ high: Int, _ target: Int) -> Int {
        if low > high {
            return -1
        }
        let mid = (low + high)/2
        if reader.get(mid) == target {
            return mid
        }
        else if reader.get(mid) > target {
            return binarySearchWith(reader, mid + 1, high, target)
        }
        else {
            return binarySearchWith(reader, low, mid - 1, target)
        }
    }
    
    static func search(_ reader: ArrayReader, _ target: Int) -> Int {
        var low = 0
        var high = 1
        if reader.get(low) > target {
            return -1
        }
        while target > reader.get(high) {
            low = high
            high = 2*high
        }
        while low <= high {
            let mid = (low + high)/2
            let val = reader.get(mid)
            if val == target {
                return mid
            }
            else if val < target {
                low = mid + 1
            }
            else {
                high = mid - 1
            }
        }
        return -1
    }
}

