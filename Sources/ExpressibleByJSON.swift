//
//  ExpressibleByJSON.swift
//  ThePrayer
//
//  Created by Julián Alonso Carballo on 18/1/17.
//  Copyright © 2017 com.julian. All rights reserved.
//

import Foundation

public protocol JSONInitializable {
    
    init(_ json: JSON?) throws
    
}

public protocol ExpressibleByJSON: JSONInitializable {
    
    var json: [String: Any] { get }
    
    init(_ json: JSON) throws
    
}

public extension JSONInitializable where Self: ExpressibleByJSON {
    
    init(_ json: JSON?) throws {
        guard let json = json else {
            throw JASONError.NilJSON(at: "\(Self.self))")
        }
        try self.init(json)
    }

}



/// Using this, we can have empty JSON objects
public protocol ExpressibleByEmptyJSON: JSONInitializable {
    
    init()
    
}

public extension JSONInitializable where Self: ExpressibleByEmptyJSON {
    
    init(_ json: JSON?) throws {
        if json != nil {
            throw JASONError.NotExpectedJSON(at: "\(Self.self)")
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
