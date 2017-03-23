//
//  Operators.swift
//  JASON
//
//  Created by Julian Parkfy on 21/3/17.
//  Copyright © 2017 Julian. All rights reserved.
//

import Foundation

precedencegroup ParsingPrecedence {
    associativity: left
    higherThan: CastingPrecedence
}

infix operator <<< : ParsingPrecedence

public func <<<<T>(object: JSON, key: String) throws -> T {
    guard let any = object[key] else {
        throw JASONError.requiredFieldNotFound(at: current(object, key))
    }
    guard let value = any as? T else {
        throw JASONError.tryingCast(object: any, to: T.self, at: current(object, key))
    }
    return value
}

public func <<<<T>(object: JSON, key: String) throws -> T where T: ConvertibleFromJSON {
    guard let any = object[key] else {
        throw JASONError.requiredFieldNotFound(at: current(object, key))
    }
    return try T.from(any, at: current(object, key))
}


public func <<<<T>(object: JSON, key: String) throws -> [T] where T: JSONInitializable {
    guard let any = object[key] else {
        throw JASONError.requiredFieldNotFound(at: current(object, key))
    }
    guard let array = any as? [JSON.JSONDictionary] else {
        throw JASONError.tryingCast(object: any, to: Array<T>.self, at: current(object, key))
    }
    return try array.map { JSON(dictionary: $0) }.map { try $0.create(T.self) }
}

//Mark - Optional
infix operator <<<? : ParsingPrecedence

public func <<<?<T>(object: JSON, key: String) -> T? {
    return object[key] as? T
}

public func <<<?<T>(object: JSON, key: String) -> T? where T: OptionalConvertibleFromJSON {
    return T.from(object[key], at: current(object, key))
}


//Creating context
fileprivate func current(_ json: JSON, _ key: String) -> Context {
    return json.context?.new(propertyName: key) ?? Context(solvingTypeName: nil, propertyName: key)
}



