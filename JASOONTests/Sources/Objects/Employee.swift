//
//  Employee.swift
//  JASON
//
//  Created by Julian Parkfy on 21/3/17.
//  Copyright © 2017 Julian. All rights reserved.
//

import Foundation
import JASOON

struct Employee {
    let name: String
    let email: String
    let age: Int
}

extension Employee: ExpressibleByJSON {
    
    init(_ json: JSON) throws {
        self.name = try json <<< .name
        self.email = try json <<< .email
        self.age = try json <<< .age
    }
    
}

fileprivate extension String {
    static let name  = "name"
    static let email = "email"
    static let age   = "age"
}
