//
//  Queue.swift
//  AdventOfCode2020
//
//  Created by Alok Karnik on 07/12/20.
//  Copyright © 2020 Alok Karnik. All rights reserved.
//

import Foundation

struct Queue<T> {
    fileprivate var array = [T]()

    var count: Int {
        return array.count
    }

    var isEmpty: Bool {
        return array.isEmpty
    }

    mutating func enqueue(_ element: T) {
        array.append(element)
    }

    mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }

    public var front: T? {
        return array.first
    }
}
