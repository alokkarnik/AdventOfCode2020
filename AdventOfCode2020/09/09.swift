//
//  09.swift
//  AdventOfCode2020
//
//  Created by Alok Karnik on 09/12/20.
//  Copyright © 2020 Alok Karnik. All rights reserved.
//

import Foundation

struct Problem_09: Puzzle {
    var input = InputFileReader.readInput(id: "09").map { Int($0)! }

    func part1() -> String {
        let preambleConst = 25
        let numbers = Array(input[preambleConst...])

        for (index, number) in numbers.enumerated() {
            let preamble = Array(input[index ..< (index + preambleConst)])

            if !isValid(number: number, preamble: preamble) {
                return "\(number)"
            }
        }
        return "No invalid number found"
    }

    func part2() -> String {
        let invalidNumber = Int(part1())!

        if let weakness = encryptionWeakness(invalidNumber: invalidNumber, input: input) {
            return "\(weakness.min()! + weakness.max()!)"
        }
        return "No weakness found"
    }

    func isValid(number: Int, preamble: [Int]) -> Bool {
        for each in preamble {
            if preamble.contains(abs(number - each)) {
                return true
            }
        }
        return false
    }

    func encryptionWeakness(invalidNumber: Int, input: [Int]) -> [Int]? {
        for (index, number) in input.enumerated() {
            var weaknessNumbers: [Int] = [number]
            var localSum = number
            var localIndex = input.index(after: index)

            while localSum <= invalidNumber, localIndex <= input.count {
                weaknessNumbers.append(input[localIndex])
                localSum += input[localIndex]
                localIndex = input.index(after: localIndex)

                if localSum == invalidNumber, weaknessNumbers.count > 1 {
                    return weaknessNumbers
                }
            }
        }
        return nil
    }
}
