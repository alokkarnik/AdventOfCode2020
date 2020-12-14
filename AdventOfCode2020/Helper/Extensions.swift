//
//  Extensions.swift
//  AdventOfCode2020
//
//  Created by Alok Karnik on 14/12/20.
//  Copyright © 2020 Alok Karnik. All rights reserved.
//

import Foundation

extension String {
    func pad(toSize: Int) -> String {
        var padded = self
        for _ in 0 ..< (toSize - count) {
            padded = "0" + padded
        }
        return padded
    }
}
