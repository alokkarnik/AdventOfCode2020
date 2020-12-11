//
//  10.swift
//  AdventOfCode2020
//
//  Created by Alok Karnik on 10/12/20.
//  Copyright © 2020 Alok Karnik. All rights reserved.
//

import Foundation

struct Problem_10: Puzzle {
    let input = InputFileReader.readInput(id: "10").map { Int($0.trimmingCharacters(in: .whitespacesAndNewlines))! }

    func part1() -> String {
        var oneVoltDifferences = 0
        var twoVoltDifferences = 0
        var threeVoltDifferences = 0

        let sortedInput = input.sorted()
        var baseVoltage = 0

        for adapter in sortedInput {
            if adapter == baseVoltage + 1 {
                baseVoltage = adapter
                oneVoltDifferences += 1
                print(adapter)
            } else if adapter == baseVoltage + 2 {
                baseVoltage = adapter
                twoVoltDifferences += 1
                print(adapter)
            } else if adapter == baseVoltage + 3 {
                baseVoltage = adapter
                threeVoltDifferences += 1
                print(adapter)
            } else if adapter == baseVoltage {
                continue
            } else {
                break
            }
        }

        return "\(oneVoltDifferences * (threeVoltDifferences + 1))"
    }

    func part2() -> String {
        let tribonachiSequence = getTribonacchiSequence(limit: 30) // [0, 1, 1, 2, 4, 7, 13, ...]

        var sortedInput = input.sorted()
        sortedInput.insert(0, at: 0)

        var paths = 1
        var index = 0

        while index < sortedInput.count - 1 {
            var localIndex = index + 1
            var localAdapter = sortedInput[index] + 1
            var consecutiveNumbers = 1

            while localIndex < sortedInput.count, localAdapter == sortedInput[localIndex] {
                consecutiveNumbers += 1

                localIndex = localIndex + 1
                localAdapter = localAdapter + 1
            }

            if consecutiveNumbers > 1 {
                paths *= tribonachiSequence[consecutiveNumbers]
                index = localIndex
            } else {
                index += 1
            }
            consecutiveNumbers = 1
        }

        return "\(paths)"
    }

    func getTribonacchiSequence(limit: Int) -> [Int] {
        var num1 = 0
        var num2 = 1
        var num3 = 1
        var sequence = [num1, num2, num3]
        for _ in 0 ..< limit - 3 {
            let addition = num1 + num2 + num3
            num1 = num2
            num2 = num3
            num3 = addition
            sequence.append(addition)
        }

        return sequence
    }
}
