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
    
    //TODO: Set string directly
    var context: Context?
    
    private(set) public var dictionary: [String: Any]?
    private(set) public var array: [[String: Any]]?
    
    public init(_ data: Data, options: JSONSerialization.ReadingOptions = .allowFragments) throws {
        let json = try JSONSerialization.jsonObject(with: data, options: options)
        switch json {
        case let dictionary as [String: Any]:
            self.dictionary = dictionary
        case let array as [[String: Any]]:
            self.array = array
        default:
            throw JASONError.typeNotRecognized(typeName: name(of: json), at: Context(solvingType: self))
        }
    }
    
    public init?(dictionary: [String: Any]?) {
        guard let dictionary = dictionary else { return nil }
        self.dictionary = dictionary
    }
    
    public init(dictionary: [String: Any]) {
        self.dictionary = dictionary
    }
    
    public init(array: [JSONDictionary]) {
        self.array = array
    }
    
    init(any: Any) throws {
        switch any {
        case let data as Data:
            try self.init(data)
        case let dictionary as JSON.JSONDictionary:
            self.init(dictionary: dictionary)
        case let array as [JSON.JSONDictionary]:
            self.init(array: array)
        default:
            throw JASONError.typeNotRecognized(typeName: name(of: any), at: Context(solvingType: JSON.self))
        }
    }
    
    private init() {}
    
    static func empty() -> JSON {
        return JSON()
    }
    
    public func create<T>(_ type: T.Type) throws -> T where T: JSONInitializable {
        return try T(self)
    }
    
}

func name(of: Any) -> String {
    return String(describing: of)
}

func name(of: Any.Type) -> String {
    return String(describing: of)
}
