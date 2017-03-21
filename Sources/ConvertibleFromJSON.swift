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
    
    static func from(_ object: Any, at: String) throws -> Self
    
}

/// Used to create not basic types with <<<? operator. Return optional types.
public protocol OptionalConvertibleFromJSON {
    
    static func from(_ object: Any?, at: String) -> Self?
    
}

extension OptionalConvertibleFromJSON where Self: ConvertibleFromJSON {
    
    public static func from(_ object: Any?, at: String) -> Self? {
        guard let object = object else { return nil }
        
        do {
            let value = try Self.from(object, at: at)
            return value
        } catch {
            debugPrint("JASON parsing error: \(error)")
            return nil
        }
    }
}

//Mark - Extension
extension URL: ConvertibleFromJSON {
    
    public static func from(_ object: Any, at: String) throws -> URL {
        guard let string = object as? String else {
            throw JASONError.TryingCast(object: object, to: "String", at: at)
        }
        guard let url = URL(string: string) else {
            throw JASONError.TryingCast(object: object, to: "URL", at: at)
        }
        
        return url
    }
    
}
