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
            var dictionary = self.any as? JSONDictionary
            dictionary?[key] = value
            if let dictionary = dictionary {
                self.any = dictionary
            }
        }
    }
    
    public subscript(key: Int) -> [String: Any]? {
        get {
            return self.array?[key]
        }
        set(value) {
            if let value = value {
                var array = self.any as? [JSONDictionary]
                array?[key] = value
                if let array = array {
                    self.any = array
                }
            }
        }
    }
    
    //TODO: Set string directly
    var context: Context?
    
    var any: Any
    
    public var dictionary: [String: Any]? {
        return self.any as? [String: Any]
    }
    public var array: [[String: Any]]? {
        return self.any as? [[String: Any]]
    }
    
    public init(data: Data, options: JSONSerialization.ReadingOptions = .allowFragments) throws {
        let json = try JSONSerialization.jsonObject(with: data, options: options)
        self.any = json
    }
    
    public init?(_ dictionary: [String: Any]?) {
        guard let dictionary = dictionary else { return nil }
        self.any = dictionary
    }
    
    public init(_ dictionary: [String: Any]) {
        self.any = dictionary
    }
    
    public init(_ array: [JSONDictionary]) {
        self.any = array
    }
    
    public init(_ any: Any) throws {
        switch any {
        case let data as Data:
            try self.init(data: data)
        case _ as NSNull:
            self.init()
        case let json as JSON:
            self.init(object: json.any)
        default:
            self.init(object: any)
        }
    }
    
    private init(object: Any) {
        self.any = object
    }
    
    
    private init() {
        self.any = NSNull()
    }
    
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
