//
//  ReadInputFile.swift
//  AdventOfCode2020
//
//  Created by Alok Karnik on 01/12/20.
//  Copyright © 2020 Alok Karnik. All rights reserved.
//

import Foundation

class InputFileReader {
    static func readInput(id: String, separator: Character = "\n") -> [String] {
        let currentDirectoryURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let bundleUrl = URL(fileURLWithPath: "InputFiles.bundle", relativeTo: currentDirectoryURL)
        let bundle = Bundle(url: bundleUrl)
        let inputFileUrl = bundle!.url(forResource: "\(id)", withExtension: nil)!
        let contents = try! String(contentsOf: inputFileUrl, encoding: .utf8)
        let input: [String] = contents.split(separator: separator).map(String.init)
        return input
    }

    static func readRawInput(id: String) -> String {
        let currentDirectoryURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let bundleUrl = URL(fileURLWithPath: "InputFiles.bundle", relativeTo: currentDirectoryURL)
        let bundle = Bundle(url: bundleUrl)
        let inputFileUrl = bundle!.url(forResource: "\(id)", withExtension: nil)!
        let contents = try! String(contentsOf: inputFileUrl, encoding: .utf8)
        return contents
    }
}
