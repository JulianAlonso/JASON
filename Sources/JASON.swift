//
//  JASON.swift
//  ThePrayer
//
//  Created by Julián Alonso Carballo on 18/1/17.
//  Copyright © 2017 com.julian. All rights reserved.
//

import Foundation

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
    
    var solvingType: Any.Type?
    var some: String?
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
            throw JASONError.TypeNotRecognized(typeName: "\(type(of: data))", at: "JSON")
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
        case is NSNull:
            return nil
        default:
            throw JASONError.TypeNotRecognized(typeName: "\(type(of: any))", at: "JSON")
        }
    }
    
    public init(_ dictionary: [String: Any]) {
        self.dictionary = dictionary
    }
    
    public init(_ array: [JSONDictionary]) {
        self.array = array
    }
    
    private init() {}
    
    static func empty() -> JSON {
        return JSON()
    }
    
    public func create<T>(_ type: T.Type) throws -> T where T: JSONInitializable {
        return try T(self)
    }
    
    
    public mutating func setSolvingType<T>(_ type: T.Type) {
        self.solvingType = type
    }
    
}
