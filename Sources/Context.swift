//
//  Context.swift
//  JASON
//
//  Created by Julian Parkfy on 23/03/2017.
//  Copyright © 2017 Julian. All rights reserved.
//

import Foundation

public struct Context {
    
    let solvingTypeName: String?
    let propertyName: String?
    
    init(solvingTypeName: String?, propertyName: String? = nil) {
        self.solvingTypeName = solvingTypeName
        self.propertyName = propertyName
    }
    
    init(solvingType: Any.Type, propertyName: String? = nil) {
        self.solvingTypeName = name(of: solvingType)
        self.propertyName = propertyName
    }
    
    init(solvingType: Any, propertyName: String? = nil) {
        self.solvingTypeName = name(of: solvingType)
        self.propertyName = propertyName
    }
    
    func new(propertyName: String) -> Context {
        return Context(solvingTypeName: self.solvingTypeName, propertyName: propertyName)
    }
    
}
