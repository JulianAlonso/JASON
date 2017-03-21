//
//  ParsingTests.swift
//  JASON
//
//  Created by Julian Parkfy on 21/3/17.
//  Copyright © 2017 Julian. All rights reserved.
//

@testable import JASON
import XCTest

final class ParsingTests: XCTestCase {
    
    func testStringIsParsingWell() {
        let data = "Object".data
        do {
            let json = try JSON(data)
            let parsed = try json.create(Parsed.self)
            
            assert(parsed.string == Parsed.Values.string)
            assert(parsed.bool == Parsed.Values.bool)
            assert(parsed.int == Parsed.Values.int)
            assert(parsed.double == Double(Parsed.Values.int))
            assert(parsed.null == nil)
            assert(parsed.array.count == Parsed.Values.array.count)
            assert(parsed.url == Parsed.Values.url)
        } catch {
            XCTFail("Not expected error: \(error)")
        }
    }
    
    func testParsingComposedJson() {
        let data = "ComposedObject".data
        do {
            let json = try JSON(data)
            let employees = try json <<< "employees" as [Employee]
            
            assert(employees.count == 4)
        } catch {
            XCTFail("Not expected error: \(error)")
        }
    }
    
}

