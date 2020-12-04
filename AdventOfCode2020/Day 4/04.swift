//
//  04.swift
//  AdventOfCode2020
//
//  Created by Alok Karnik on 04/12/20.
//  Copyright © 2020 Alok Karnik. All rights reserved.
//

import Foundation

struct Problem_04: Puzzle {
    var passports = [[String: String]]()

    init() {
        passports = parseRawInput()
    }

    func part1() -> String {
        var validPassports = 0

        for individualPassport in passports {
            if isValid(passport: individualPassport) {
                validPassports += 1
            }
        }
        return "\(validPassports)"
    }

    func part2() -> String {
        var validPassports = 0

        for individualPassport in passports {
            if isValid(passport: individualPassport),
                isValid(byr: individualPassport["byr"]!),
                isValid(iyr: individualPassport["iyr"]!),
                isValid(eyr: individualPassport["eyr"]!),
                isValid(hgt: individualPassport["hgt"]!),
                isValid(hcl: individualPassport["hcl"]!),
                isValid(ecl: individualPassport["ecl"]!),
                isValid(pid: individualPassport["pid"]!) {
                validPassports += 1
            }
        }

        return "\(validPassports)"
    }

    func isValid(passport: [String: String]) -> Bool {
        return (passport.count == 8 || (passport.count == 7 && passport["cid"] == nil))
    }

    func isValid(byr: String) -> Bool {
        if byr.count == 4, let byr = Int(byr), byr >= 1920, byr <= 2002 {
            return true
        }
        return false
    }

    func isValid(iyr: String) -> Bool {
        if iyr.count == 4, let iyr = Int(iyr), iyr >= 2010, iyr <= 2020 {
            return true
        }
        return false
    }

    func isValid(eyr: String) -> Bool {
        if eyr.count == 4, let eyr = Int(eyr), eyr >= 2020, eyr <= 2030 {
            return true
        }
        return false
    }

    func isValid(hgt: String) -> Bool {
        if hgt.contains("in"), let heightInInches = Int(hgt.dropLast(2)), heightInInches >= 59, heightInInches <= 76 {
            return true
        } else if hgt.contains("cm"), let heightInCM = Int(hgt.dropLast(2)), heightInCM >= 150, heightInCM <= 193 {
            return true
        }
        return false
    }

    func isValid(hcl: String) -> Bool {
        if hcl.count == 7, hcl.first == "#", hcl.range(of: "[^a-zA-Z0-9]", options: .regularExpression) != nil {
            return true
        }
        return false
    }

    func isValid(ecl: String) -> Bool {
        let validEyeColors = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
        if validEyeColors.contains(ecl) {
            return true
        }
        return false
    }

    func isValid(pid: String) -> Bool {
        if pid.count == 9 {
            return true
        }
        return false
    }
}

extension Problem_04 {
    func parseRawInput() -> [[String: String]] {
        let rawInput = InputFileReader.readRawInput(id: "04").components(separatedBy: "\n\n")
        var sanitizedInput = [[String: String]]()
        for rawPassport in rawInput {
            var sanitizedPassport = [String: String]()
            let passportArray = rawPassport.components(separatedBy: "\n").flatMap { $0.components(separatedBy: " ") }.filter { (field) -> Bool in
                field != ""
            }
            passportArray.forEach { field in
                let splitField = field.split(separator: ":")
                if splitField.count != 2 {
                    print(splitField)
                }
                sanitizedPassport[String(splitField[0])] = String(splitField[1])
            }
            sanitizedInput.append(sanitizedPassport)
        }

        return sanitizedInput
    }
}
