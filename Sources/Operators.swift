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
        throw JASONError.RequiredFieldNotFound(fieldName: key, at: "\(object.solvingType ?? Any.self)")
    }
    guard let value = any as? T else {
        throw JASONError.TryingCast(object: object, to: "\(type(of: T.self))", at: "\(object.solvingType ?? Any.self)")
    }
    return value
}

public func <<<<T>(object: JSON, key: String) throws -> T where T: ConvertibleFromJSON {
    guard let any = object[key] else {
        throw JASONError.RequiredFieldNotFound(fieldName: key, at: "\(object.solvingType ?? Any.self)")
    }
    return try T.from(any, at: "\(object.solvingType ?? Any.self)")
}


public func <<<<T>(object: JSON, key: String) throws -> [T] where T: JSONInitializable {
    guard let any = object[key] else {
        throw JASONError.RequiredFieldNotFound(fieldName: key, at: "\(object.solvingType ?? Any.self)")
    }
    let json = try JSON(any)
    guard let array = json?.array else {
        throw JASONError.Malformed(fieldname: key, at: "\(object.solvingType ?? Any.self)")
    }
    return try array.map { JSON($0) }.map { try $0.create(T.self) }
}

//Mark - Optional
infix operator <<<? : ParsingPrecedence

public func <<<?<T>(object: JSON, key: String) -> T? {
    return object[key] as? T
}
