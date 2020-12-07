//
//  Stack.swift
//  AdventOfCode2020
//
//  Created by Alok Karnik on 08/12/20.
//  Copyright © 2020 Alok Karnik. All rights reserved.
//

import Foundation

struct Stack<T> {
    fileprivate var array = [T]()

    var isEmpty: Bool {
        return array.isEmpty
    }

    var count: Int {
        return array.count
    }

    mutating func push(_ element: T) {
        array.append(element)
    }

    mutating func pop() -> T? {
        return array.popLast()
    }

    var top: T? {
        return array.last
    }
}
