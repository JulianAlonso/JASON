//
//  JSONOperations.swift
//  ThePrayer
//
//  Created by Julián Alonso Carballo on 18/1/17.
//  Copyright © 2017 com.julian. All rights reserved.
//

import Foundation

public extension JSON {
    public static func String(_ object: Any) throws -> String {
        guard let value = object as? String else {
            throw JASONError.TryingCast(object: object, to: "String")
        }
        return value
    }
    
    public static func Object(_ object: Any) throws -> JSON {
        guard let value = object as? JSON.JSONDictionary else {
            throw JASONError.TryingCast(object: object, to: "[String : Any]")
        }
        return JSON(value)
    }
    
    public static func List(_ object: Any) throws -> [JSON] {
        guard let value = object as? [JSON.JSONDictionary] else {
            throw JASONError.TryingCast(object: object, to: "Array<[String : Any]>")
        }
        return value.map { JSON($0) }
    }
    
    public static func Double(_ object: Any) throws -> Double {
        guard let value = object as? Double else {
            throw JASONError.TryingCast(object: object, to: "Double")
        }
        return value
    }
    
    public static func Int(_ object: Any) throws -> Int {
        guard let value = object as? Int else {
            throw JASONError.TryingCast(object: object, to: "Int")
        }
        return value
    }
    
    public static func Bool(_ object: Any) throws -> Bool {
        guard let value = object as? Bool else {
            throw JASONError.TryingCast(object: object, to: "Bool")
        }
        return value
    }
    
    public static func DoubleFromString(_ object: Any) throws -> Double {
        guard let stringValue = object as? String else {
            throw JASONError.TryingCast(object: object, to: "String")
        }
        guard let value = Swift.Double(stringValue) else {
            throw JASONError.TryingCast(object: object, to: "Double")
        }
        return value
    }
    
    public static func IntFromString(_ object: Any) throws -> Int {
        guard let stringValue = object as? String else {
            throw JASONError.TryingCast(object: object, to: "String")
        }
        guard let value = Swift.Int(stringValue) else {
            throw JASONError.TryingCast(object: object, to: "Int")
        }
        return value
    }
    
    public static func URL(_ object: Any) throws -> URL {
        guard let stringValue = object as? String else {
            throw JASONError.TryingCast(object: object, to: "String")
        }
        guard let value = Foundation.URL(string: stringValue) else {
            throw JASONError.TryingCast(object: object, to: "URL")
        }
        return value
    }
}

public extension JSON {
    
    public struct Optional {
        public static func String(_ object: Any?) -> String? {
            return object as? String
        }
        
        public static func URL(_ object: Any?) -> URL? {
            if let stringValue = object as? String {
                return Foundation.URL(string: stringValue)
            }
            return nil
        }
        
        public static func Int(_ object: Any?) -> Int? {
            return object as? Int
        }
        
        public static func DoubleFromString(_ object: Any?) -> Double? {
            var value: Swift.Double?
            if let stringValue = object as? String {
                if let double = Swift.Double(stringValue) {
                    value = double
                }
            }
            return value
        }
        
        public static func Double(_ object: Any?) -> Double? {
            if let value = object as? Double {
                return value
            }
            return nil
        }
        
        public static func Object(_ object: Any?) -> JSON? {
            var value: [String: Any]?
            if let objectValue = object as? [String: Any] {
                value = objectValue
            }
            return JSON(value)
        }
    }
}

