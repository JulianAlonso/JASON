//
//  JASON.swift
//  ThePrayer
//
//  Created by Julián Alonso Carballo on 18/1/17.
//  Copyright © 2017 com.julian. All rights reserved.
//

import Foundation

//MARK: - JASON Parsing operators
precedencegroup ParsingPrecedence {
    associativity: left
    higherThan: AdditionPrecedence
}

infix operator >>> : ParsingPrecedence
public func >>><T, A>(a: T, f: (_ object: T) throws -> A) rethrows -> A {
    let value = try f(a)
    return value
}

infix operator <<< : ParsingPrecedence
public func <<<(object: JSON, key: String) throws -> Any {
    guard let value = object[key] else {
        throw JASONError.RequiredFieldNotFound(fieldName: key)
    }
    return value
}

infix operator <<<? : ParsingPrecedence
public func <<<?(object: JSON, key: String) -> Any? {
    return object[key] as Any?
}

//MARK: - Creation
public struct JSON {
    
    public typealias JSONDictionary = [String: Any]
    
    public subscript(key: String) -> Any? {
        get {
            return self.dictionary?[key]
        }
        set(value) {
            self.dictionary?[key] = value
        }
    }
    
    public subscript(key: Int) -> [String: Any]? {
        get {
            return self.array?[key]
        }
        set(value) {
            if let value = value {
                self.array?[key] = value
            }
        }
    }
    
    private(set) public var dictionary: [String: Any]?
    private(set) public var array: [[String: Any]]?
    
    public init(_ data: Data) throws {
        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        switch json {
        case let dictionary as [String: Any]:
            self.dictionary = dictionary
        case let array as [[String: Any]]:
            self.array = array
        default:
            throw JASONError.TypeNotRecognized(typeName: "\(type(of: data))")
        }
    }
    
    public init?(_ dictionary: [String: Any]?) {
        guard let dictionary = dictionary else { return nil }
        self.dictionary = dictionary
    }
    
    public init?(_ any: Any) throws {
        switch any {
        case let data as Data:
            try self.init(data)
        case let dictionary as JSONDictionary:
            self.init(dictionary)
        case let array as [JSONDictionary]:
            self.init(array)
        case let _ as NSNull:
            return nil
        default:
            throw JASONError.TypeNotRecognized(typeName: "\(type(of: any))")
        }
    }
    
    public init(_ dictionary: [String: Any]) {
        self.dictionary = dictionary
    }
    
    public init(_ array: [JSONDictionary]) {
        self.array = array
    }
    
    private init() {
        self.dictionary = [:]
    }
    
    static func empty() -> JSON {
        return JSON()
    }
    
}
