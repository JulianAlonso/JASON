//
//  Parsed.swift
//  JASON
//
//  Created by Julian Parkfy on 21/3/17.
//  Copyright © 2017 Julian. All rights reserved.
//

import Foundation
import JASON

struct Parsed {
    let string: String
    let int: Int
    let double: Double
    let bool: Bool
    let null: String?
    let url: URL
    let optURL: URL?
    let array: [String]
}

extension Parsed: ExpressibleByJSON {
    
    init(_ json: JSON) throws {
        self.string = try json <<< Parsed.Fields.string
        self.int = try json <<< Parsed.Fields.int
        self.bool = try json <<< Parsed.Fields.bool
        self.double = try json <<< Parsed.Fields.int
        self.null = json <<<? Parsed.Fields.int
        self.url = try json <<< Parsed.Fields.url
        self.optURL = json <<<? Parsed.Fields.url
        self.array = try json <<< Parsed.Fields.array
    }
    
}

extension Parsed {
    
    struct Values {
        static let string = "lorem"
        static let int    = 123
        static let bool   = false
        static let array  = ["one", "two", "three", "four"]
        static let url    = URL(string: "www.diariodeprogramacion.com")!
    }
    
    struct Fields {
        static let string = "string"
        static let int    = "int"
        static let bool   = "bool"
        static let null   = "null"
        static let url    = "url"
        static let array  = "array"
    }
    
}
