//
//  Vertex.swift
//  AdventOfCode2020
//
//  Created by Alok Karnik on 07/12/20.
//  Copyright © 2020 Alok Karnik. All rights reserved.
//

import Foundation

struct Vertex<T: Hashable> {
    var data: T
}

extension Vertex: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(data)
    }

    static func == (lhs: Vertex, rhs: Vertex) -> Bool {
        return lhs.data == rhs.data
    }
}

extension Vertex: CustomStringConvertible {
    var description: String {
        return "\(data)"
    }
}
