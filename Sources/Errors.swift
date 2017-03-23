//
//  Errors.swift
//  ThePrayer
//
//  Created by Julián Alonso Carballo on 18/1/17.
//  Copyright © 2017 com.julian. All rights reserved.
//

import Foundation

public enum JASONError: Error {
    
    case nilJSON(at: Context)
    case notExpectedJSON(at: Context)
    
    case typeNotRecognized(typeName: String, at: Context)
    case requiredFieldNotFound(at: Context)
    case tryingCast(object: Any, to: Any.Type, at: Context)
    
    
}

extension JASONError: CustomStringConvertible {
    public var description: String {
        return self.debugDescription
    }
}

extension JASONError: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .nilJSON(let context):
            return "JASON ERROR: nil JSON object creating type: \(context.solvingTypeName ?? "Unknown type")"
        case .notExpectedJSON(let context):
            return "JASON ERROR: received not expected JSON object creating type: \(context.solvingTypeName  ?? "Unknown type")"
        case let .typeNotRecognized(typeName, context):
            return "JASON ERROR: type \(typeName) not recognized parsing \(context.propertyName ?? "Unknown property") creating type: \(context.solvingTypeName ?? "Unknown type")"
        case let .requiredFieldNotFound(context):
            return "JASON ERROR: required field \(context.propertyName ?? "Unknown property") not found creating type: \(context.solvingTypeName ?? "Unknown type")"
        case let .tryingCast(object, type, context):
            return "JASON ERROR: trying cast \(object) to type: \(type) at property \(context.propertyName ?? "Unknown property") creating type \(context.solvingTypeName ?? "Unknown type")"
        }
    }
}
