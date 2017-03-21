//
//  Errors.swift
//  ThePrayer
//
//  Created by Julián Alonso Carballo on 18/1/17.
//  Copyright © 2017 com.julian. All rights reserved.
//

import Foundation

public enum JASONError: Error {
    
    case NilJSON(at: String)
    case NotExpectedJSON(at: String)
    case TypeNotRecognized(typeName: String)
    case RequiredFieldNotFound(fieldName: String)
    case Malformed(fieldname: String)
    case TryingCast(object: Any, to: String)
    case NotImplementedYet
    
}
