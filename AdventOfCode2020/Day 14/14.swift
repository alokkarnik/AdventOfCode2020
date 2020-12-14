//
//  14.swift
//  AdventOfCode2020
//
//  Created by Alok Karnik on 14/12/20.
//  Copyright © 2020 Alok Karnik. All rights reserved.
//

import Foundation

typealias MemoryRepresentation = (address: Int, value: Int)

struct Problem_14: Puzzle {
    let input = InputFileReader.readInput(id: "14")
    func part1() -> String {
        var currentMask = [Int: Character]()
        var address = [Int: Int]()

        for line in input {
            if line.contains("mask") {
                currentMask = getMaskRepresentation(line.components(separatedBy: "=")[1].trimmingCharacters(in: .whitespacesAndNewlines), ignoringChar: "X")
            } else {
                let sanitizedInput = parse(instruction: line)
                address[sanitizedInput.address] = getValue(number: sanitizedInput.value, mask: currentMask)
            }
        }

        return "\(address.values.reduce(0, +))"
    }

    func part2() -> String {
        var currentMask = [Int: Character]()
        var address = [Int: Int]()

        for line in input {
            if line.contains("mask") {
                currentMask = getMaskRepresentation(line.components(separatedBy: "=")[1].trimmingCharacters(in: .whitespacesAndNewlines), ignoringChar: "0")
            } else {
                let sanitizedInput = parse(instruction: line)
                let maskedAddress = getValueStr(number: sanitizedInput.address, mask: currentMask)
                let addresses = getAddresses(address: maskedAddress)
                for memAddress in addresses {
                    address[memAddress] = sanitizedInput.value
                }
            }
        }

        return "\(address.values.reduce(0, +))"
    }
}

extension Problem_14 {
    func parse(instruction: String) -> MemoryRepresentation {
        let strInput = instruction.replacingOccurrences(of: "mem[", with: "").replacingOccurrences(of: "]", with: "").trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: "=")

        return MemoryRepresentation(Int(strInput[0].trimmingCharacters(in: .whitespacesAndNewlines))!, Int(strInput[1].trimmingCharacters(in: .whitespacesAndNewlines))!)
    }

    func getMaskRepresentation(_ mask: String, ignoringChar: Character) -> [Int: Character] {
        var maskRepr = [Int: Character]()
        for (index, maskingVal) in mask.enumerated() {
            if maskingVal != ignoringChar {
                maskRepr[index] = maskingVal
            }
        }

        return maskRepr
    }

    func getValue(number: Int, mask: [Int: Character]) -> Int {
        var binaryNumber = Array(String(number, radix: 2).pad(toSize: 36))
        for makedDigits in mask {
            binaryNumber[makedDigits.key] = makedDigits.value
        }

        return Int(String(binaryNumber), radix: 2)!
    }

    func getValueStr(number: Int, mask: [Int: Character]) -> String {
        var binaryNumber = Array(String(number, radix: 2).pad(toSize: 36))
        for makedDigits in mask {
            binaryNumber[makedDigits.key] = makedDigits.value
        }

        return String(binaryNumber)
    }

    func getAddresses(address: String) -> [Int] {
        var addressPermutation = [Int]()
        var stack = Stack<String>()
        stack.push(address)

        while !stack.isEmpty {
            let top = stack.pop()!
            if top.contains("X") {
                var arr = Array(top)
                let idx = arr.firstIndex(of: "X")!
                arr[idx] = "0"
                stack.push(String(arr))
                arr[idx] = "1"
                stack.push(String(arr))
            } else {
                addressPermutation.append(Int(top, radix: 2)!)
            }
        }

        return addressPermutation
    }
}
