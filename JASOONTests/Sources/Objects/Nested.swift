//
//  Nested.swift
//  JASON
//
//  Created by Julian Parkfy on 21/3/17.
//  Copyright © 2017 Julian. All rights reserved.
//

import Foundation
import JASOON

struct Nested {
    let employee: Employee
}

extension Nested: ExpressibleByJSON {
    
    init(_ json: JSON) throws {
        self.employee = try json <<< .employee
    }
    
}

fileprivate extension String {
    static let some = "some"
    static let employee = "employee"
}
