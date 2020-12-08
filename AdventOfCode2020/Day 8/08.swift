//
//  08.swift
//  AdventOfCode2020
//
//  Created by Alok Karnik on 08/12/20.
//  Copyright © 2020 Alok Karnik. All rights reserved.
//

import Foundation

struct Problem_08: Puzzle {
    let input: [String]

    init() {
        input = InputFileReader.readInput(id: "08")
    }

    func part1() -> String {
        return "\(solve(bootCode: input).accumulator)"
    }

    func part2() -> String {
        for (index, var instruction) in input.enumerated() {
            var tempInput = input
            if instruction.contains("nop") {
                instruction = instruction.replacingOccurrences(of: "nop", with: "jmp")
            } else if instruction.contains("jmp") {
                instruction = instruction.replacingOccurrences(of: "jmp", with: "nop")
            }
            tempInput[index] = instruction
            let output = solve(bootCode: tempInput)

            if output.reachedEnd {
                return "\(output.accumulator)"
            }
        }
        return "Failed to find any bad instruction."
    }

    func solve(bootCode: [String]) -> (accumulator: Int, reachedEnd: Bool) {
        var accumulator = 0
        var index = 0
        var instructionSolved = [Int: Bool]()

        while instructionSolved[index] == nil, index != bootCode.count {
            instructionSolved[index] = true
            let currentInstructionSet = bootCode[index].components(separatedBy: " ")
            let instruction = currentInstructionSet[0]
            let value = Int(currentInstructionSet[1].replacingOccurrences(of: "+", with: "").trimmingCharacters(in: .whitespacesAndNewlines))!
            if instruction == "acc" {
                accumulator += value
                index += 1
            } else if instruction == "nop" {
                index += 1
            } else if instruction == "jmp" {
                index += value
            }
        }

        return (accumulator, index == bootCode.count)
    }
}
