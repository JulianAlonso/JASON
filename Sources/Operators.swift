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
postfix operator <<<

public func <<<<T>(object: JSON, key: String) throws -> T {
    print("Primitive")
    guard let any = object[key] else {
        throw JASONError.requiredFieldNotFound(at: current(object, key))
    }
    guard let value = any as? T else {
        throw JASONError.tryingCast(object: any, to: T.self, at: current(object, key))
    }
    return value
}


public postfix func <<<<T>(object: JSON) throws -> T {
    guard let value = object.any as? T else {
        throw JASONError.tryingCast(object: object.any, to: T.self, at: current(object, "no key"))
    }
    return value
}

public func <<<<T>(object: JSON, key: String) throws -> T where T: ConvertibleFromJSON {
    print("Convertible")
    guard let any = object[key] else {
        throw JASONError.requiredFieldNotFound(at: current(object, key))
    }
    return try T.from(any, at: current(object, key))
}

public postfix func <<<<T>(object: JSON) throws -> T where T: ConvertibleFromJSON {
    return try T.from(object.any, at: current(object, "no key"))
}

public func <<<<T>(object: JSON, key: String) throws -> [T] where T: ConvertibleFromJSON {
    print("Array with: \(object)")
    guard let any = object[key] else {
        throw JASONError.requiredFieldNotFound(at: current(object, key))
    }
    print("Any: \(any)")
    guard let array = any as? [JSON.JSONDictionary] else {
        throw JASONError.tryingCast(object: any, to: Array<JSON.JSONDictionary>.self, at: current(object, key))
    }
    return try array.map { aa -> JSON in
        print("first map: $0 \(aa)")
        return JSON(aa)
    }.map { aa -> T in
        print("second map: $0 \(aa)")
        return try T.from(aa, at: current(object, key))
    }
}

public postfix func <<<<T>(object: JSON) throws -> [T] where T: ConvertibleFromJSON {
    guard let array = object.any as? [JSON.JSONDictionary] else {
        throw JASONError.tryingCast(object: object.any, to: Array<JSON.JSONDictionary>.self, at: current(object, "no key"))
    }
    
    return try array.map { JSON($0) }.map { try T.from($0, at: current(object, "no key")) }
}


//Mark - Optional
infix operator <<<? : ParsingPrecedence

postfix operator <<<?

public func <<<?<T>(object: JSON, key: String) -> T? {
    return object[key] as? T
}

public func <<<?<T>(object: JSON, key: String) -> T? where T: OptionalConvertibleFromJSON {
    return T.from(object[key], at: current(object, key))
}

public func <<<?<T>(object: JSON, key: String) -> [T]? where T: OptionalConvertibleFromJSON {
    let array = object[key] as? [JSON.JSONDictionary]
    if let array = array {
        return array.map { JSON($0) }.flatMap { T.from($0, at: current(object, key)) }
    }
    return nil
}


public postfix func <<<?<T>(object: JSON) -> T? {
    return object.any as? T
}

public postfix func <<<?<T>(object: JSON) -> T? where T: OptionalConvertibleFromJSON {
    return T.from(object.any, at: current(object, "no key"))
}

public postfix func <<<?<T>(object: JSON) -> [T]? where T: OptionalConvertibleFromJSON {
    let array = object.any as? [JSON.JSONDictionary]
    if let array = array {
        return array.map { JSON($0) }.flatMap { T.from($0, at: current(object, "no key")) }
    }
    return nil
}

//Creating context
fileprivate func current(_ json: JSON, _ key: String) -> Context {
    return json.context?.new(propertyName: key) ?? Context(solvingTypeName: nil, propertyName: key)
}



