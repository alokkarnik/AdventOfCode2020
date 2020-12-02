//
//  01.swift
//  AdventOfCode2020
//
//  Created by Alok Karnik on 01/12/20.
//  Copyright © 2020 Alok Karnik. All rights reserved.
//

import Foundation

struct Problem_01 {
    let input: [Int]

    init() {
        input = InputFileReader.readInput(id: "01").compactMap { Int($0) }
    }

    func part1() -> Int {
        let sortedInput = input.sorted()
        var start = sortedInput.startIndex
        var end = sortedInput.endIndex - 1

        while start < end {
            let sum = sortedInput[start] + sortedInput[end]
            if sum == 2020 {
                return sortedInput[start] * sortedInput[end]
            } else if sum > 2020 {
                end = sortedInput.index(before: end)
            } else {
                start = sortedInput.index(after: start)
            }
        }
        return -1
    }

    func part2() -> Int {
        let sortedInput = input.sorted()

        for i in sortedInput.startIndex ..< sortedInput.endIndex {
            var start = i + 1
            var end = sortedInput.endIndex - 1

            while start < end {
                let sum = sortedInput[start] + sortedInput[end] + sortedInput[i]
                if sum == 2020 {
                    return sortedInput[start] * sortedInput[end] * sortedInput[i]
                } else if sum > 2020 {
                    end = sortedInput.index(before: end)
                } else {
                    start = sortedInput.index(after: start)
                }
            }
        }

        return -1
    }
}
