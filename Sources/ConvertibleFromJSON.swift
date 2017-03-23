//
//  JSONConvertible.swift
//  JASON
//
//  Created by Julian Parkfy on 21/3/17.
//  Copyright © 2017 Julian. All rights reserved.
//

import Foundation


///
/// Used to create not basic types with <<< operator
public protocol ConvertibleFromJSON: OptionalConvertibleFromJSON {
    
    static func from(_ object: Any, at context: Context) throws -> Self
    
}

/// Used to create not basic types with <<<? operator. Return optional types.
public protocol OptionalConvertibleFromJSON {
    
    static func from(_ object: Any?, at context: Context) -> Self?
    
}

public extension OptionalConvertibleFromJSON where Self: ConvertibleFromJSON {
    
    public static func from(_ object: Any?, at context: Context) -> Self? {
        guard let object = object else { return nil }
        
        do {
            let value = try Self.from(object, at: context)
            return value
        } catch {
            debugPrint("JASON parsing error: \(error)")
            return nil
        }
    }
}

//Mark - Extension
extension URL: ConvertibleFromJSON {
    
    public static func from(_ object: Any, at context: Context) throws -> URL {
        guard let string = object as? String else {
            throw JASONError.tryingCast(object: object, to: String.self, at: context)
        }
        guard let url = URL(string: string) else {
            throw JASONError.tryingCast(object: string, to: URL.self, at: context)
        }
        return url
    }
    
}

extension JSON: ConvertibleFromJSON {
    
    public static func from(_ object: Any, at context: Context) throws -> JSON {
        return try JSON(any: object)
    }
    
}
