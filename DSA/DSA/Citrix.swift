//
//  Citrix.swift
//  DSA
//
//  Created by Nishit on 27/11/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

extension Problems {
    static func threeSum(_ nums: [Int]) -> [[Int]] {
        if nums.count <= 2 {
            return []
        }
        
        let target = 0
        let list = nums.sorted()
        let length = list.count
        var result = [[Int]]()
        var set = Set<String>()
        
        for i in 0..<length - 2 {
            var l = i + 1
            var r = length - 1
            while l < r {
                let sum = list[i] + list[l] + list[r]
                if target > sum {
                    l += 1
                }
                else if sum > target {
                    r -= 1
                }
                else {
                    let s = "\(list[i]),\(list[l]),\(list[r])"
                    if !set.contains(s) {
                        set.insert(s)
                        let val = [list[i], list[l], list[r]]
                        result.append(val)
                    }
                    l += 1
                    r -= 1
                }
            }
        }
        return result
    }
    
    static func maxEvents(_ events: [[Int]]) -> Int {
        if events.isEmpty {
            return 0
        }
        let list = events.sorted { (first, second) -> Bool in
            first[0] < second[0]
        }
        
        let queue = Heap<Int>(type: .minHeap)
        queue.insert(element: list[0][1])
        var counter = 1
        for i in 1..<list.count {
            let item = list[i]
            if let top = queue.getRoot() {
                if item[0] >= top {
                    let _ = queue.extract()
                }
                else {
                    counter += 1
                }
            }
            queue.insert(element: item[1])
        }
        return counter
    }
    
    func canCompleteGasStationCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
        var start = 0
        var totalTank = 0
        var currTank = 0
        let length = gas.count
        for i in 0..<length {
            totalTank += gas[i] - cost[i]
            currTank += gas[i] - cost[i]
            if currTank < 0 {
                start = (i + 1) % length
                currTank = 0
            }
        }
        return totalTank >= 0 ? start : -1
    }
    
    static func findShortestSubArrayWithMaxDegree(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        
        var map = [Int: [Int]]()
        for (idx, num) in nums.enumerated() {
            map[num, default: []].append(idx)
        }
        
        let degree = map.values.map({ $0.count }).max() ?? 0
        
        return map.filter({ (key, value) -> Bool in
            value.count == degree
        }).map({ (key, value) -> Int in
            return value.max()! - value.min()! + 1
        }).min()!
    }
    
    static func findMinDistanceWithDijkstra(_ graph: [[Int]], _ source: Int, _ n: Int, _ threshold: Int) -> [Int] {
        var distance = Array(repeating: Int.max, count: n)
        distance[source] = 0
        let queue = Heap<Int>(type: .maxHeap)
        queue.insert(element: source)
        while !queue.isEmpty {
            if let node = queue.extract() {
                let list = graph[node]
                for i in 0..<list.count {
                    if graph[node][i] != 0 {
                        let x = distance[node] + graph[node][i]
                        if x <= threshold && distance[i] > x {
                            distance[i] = x
                            queue.insert(element: i)
                        }
                    }
                }
            }
        }
        return distance
    }
    
    static func findTheCity(_ n: Int, _ edges: [[Int]], _ distanceThreshold: Int) -> Int {
        if n <= 1 || edges.isEmpty {
            return 0
        }
        
        var map = Array(repeating: Array(repeating: 0, count: n), count: n)
        for item in edges {
            let x = item[0]
            let y = item[1]
            let w = item[2]
            map[x][y] = w
            map[y][x] = w
        }
        
        var distMap = [GrapthItem]()
        for i in 0..<n {
            let dist = findMinDistanceWithDijkstra(map, i, n, distanceThreshold)
            let distanceList = dist.filter { (item) -> Bool in
                item != Int.max
            }
            let x = GrapthItem(item: i, count: distanceList.count, list: dist)
            distMap.append(x)
        }
        
        let min = distMap.map { $0.count }.min()!
        let values = distMap.filter { $0.count == min }
    
        var greaterVal = Int.min
        for item in values {
            if item.item > greaterVal {
                greaterVal = item.item
            }
        }
        return greaterVal
    }
    
    func minMeetingRooms(_ intervals: [[Int]]) -> Int {
        if intervals.isEmpty {
            return 0
        }
        let list = intervals.sorted { (first, second) -> Bool in
            first[0] < second[0]
        }
        
        let queue = Heap<Int>(type: .minHeap)
        queue.insert(element: list[0][1])
        var counter = 1
        for i in 1..<list.count {
            let item = list[i]
            if let top = queue.getRoot() {
                if item[0] >= top {
                    let _ = queue.extract()
                }
                else {
                    counter += 1
                }
            }
            queue.insert(element: item[1])
        }
        return counter
    }
}

struct GrapthItem {
    let item: Int
    let count: Int
    let list: [Int]
}
