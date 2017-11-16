//
//  ExpressibleByJSON.swift
//  ThePrayer
//
//  Created by Julián Alonso Carballo on 18/1/17.
//  Copyright © 2017 com.julian. All rights reserved.
//

import Foundation

public protocol JSONInitializable: ConvertibleFromJSON {
    
    init(_ json: JSON?) throws
    
}

public extension ConvertibleFromJSON where Self: JSONInitializable {
    
    static func from(_ object: Any, at context: Context) throws -> Self {
        return try Self.init(JSON(object))
    }
    
}

public protocol ExpressibleByJSON: JSONInitializable {
    
    var json: [String: Any] { get }
    
    init(_ json: JSON) throws
    
}

public extension JSONInitializable where Self: ExpressibleByJSON {
    
    init(_ json: JSON?) throws {
        let context = Context(solvingType: Self.self)
        guard let json = json else {
            throw JASONError.nilJSON(at: context)
        }
        var _json = json
        _json.context = context
        try self.init(_json)
    }

}


/// Using this, we can have empty JSON objects
public protocol ExpressibleByEmptyJSON: JSONInitializable {
    
    init()
    
}

public extension JSONInitializable where Self: ExpressibleByEmptyJSON {
    
    init(_ json: JSON?) throws {
        if json?.array != nil || json?.dictionary != nil {
            throw JASONError.notExpectedJSON(at: Context(solvingType: Self.self))
        }
        self.init()
    }
    
}



public extension ExpressibleByJSON {
    
    ///Returns empty json, by this way implementation its optional
    var json: [String: Any] {
        return [String: Any]()
    }
    
}
