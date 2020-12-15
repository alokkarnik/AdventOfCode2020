//
//  15.swift
//  AdventOfCode2020
//
//  Created by Alok Karnik on 15/12/20.
//  Copyright © 2020 Alok Karnik. All rights reserved.
//

import Foundation

struct Problem_15: Puzzle {
    let input = InputFileReader.readInput(id: "15")[0].trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: ",").map { Int($0)! }

    func part1() -> String {
        return "\(numberInMemoryAt(index: 2020))"
    }

    func part2() -> String {
        return "\(numberInMemoryAt(index: 30_000_000))"
    }

    func numberInMemoryAt(index: Int) -> Int {
        var lookup = [Int: Int]()

        for (index, num) in input.enumerated() {
            lookup[num] = index + 1
        }

        var lastNumber = 0
        var count = input.count + 1
        var nextNumber = 0

        while count < index {
            if let memLookup = lookup[lastNumber] {
                lookup[lastNumber] = count
                nextNumber = count - memLookup
            } else {
                lookup[lastNumber] = count
                nextNumber = 0
            }
            lastNumber = nextNumber
            count += 1
        }

        return lastNumber
    }
}
