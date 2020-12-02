//
//  02.swift
//  AdventOfCode2020
//
//  Created by Alok Karnik on 02/12/20.
//  Copyright © 2020 Alok Karnik. All rights reserved.
//

import Foundation

typealias PasswordInput = (min: Int, max: Int, letter: Character, password: String)

struct Problem_02 {
    var input: [PasswordInput] = []

    init() {
        input = parse(input: InputFileReader.readInput(id: "02"))
    }

    func part1() -> Int {
        var validPasswords = 0

        for passwordInput in input {
            let count = passwordInput.password.filter { $0 == passwordInput.letter }.count
            if count >= passwordInput.min, count <= passwordInput.max {
                validPasswords += 1
            }
        }

        return validPasswords
    }

    func part2() -> Int {
        var validPasswords = 0

        for passwordInput in input {
            let passwordString = passwordInput.password
            let charAtFirstIndex = passwordString[passwordString.index(passwordString.startIndex, offsetBy: passwordInput.min - 1)]
            let charAtSecondIndex = passwordString[passwordString.index(passwordString.startIndex, offsetBy: passwordInput.max - 1)]

            if charAtFirstIndex == passwordInput.letter || charAtSecondIndex == passwordInput.letter,
                charAtSecondIndex != charAtFirstIndex {
                validPasswords += 1
            }
        }

        return validPasswords
    }
}

extension Problem_02 {
    func parse(input: [String]) -> [PasswordInput] {
        var parsedInput = [PasswordInput]()
        for passwordInput in input {
            let splitInput = passwordInput.split(separator: " ").map { String($0) }
            let minMax = splitInput[0].split(separator: "-").map { String($0) }
            let char = splitInput[1].split(separator: ":").map { String($0) }

            let inputStr: PasswordInput = (min: Int(minMax[0])!, max: Int(minMax[1])!, letter: Character(char[0]), password: String(splitInput[2]))

            parsedInput.append(inputStr)
        }

        return parsedInput
    }
}
