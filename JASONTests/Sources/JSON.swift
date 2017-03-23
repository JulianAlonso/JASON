//
//  ParsingTests.swift
//  JASON
//
//  Created by Julian Parkfy on 21/3/17.
//  Copyright © 2017 Julian. All rights reserved.
//

@testable import JASON
import XCTest

final class JSONTest: XCTestCase {
    
    func testSolvingTypeIsSettedWhenCallingJSONInitializableConstructor() {
        let data = "Object".data
        do {
            let json = try JSON(data)
            let parsed = try json.create(Test.self)
            print(parsed.parsingType)
            XCTAssertTrue(parsed.parsingType.contains("Test"), "parsingType must contain Test object name")
        } catch {
            XCTFail("Not expected error: \(error)")
        }
    }    
    
}


fileprivate struct Test {
    let parsingType: String
}

extension Test: ExpressibleByJSON {
    
    init(_ json: JSON) throws {
        self.parsingType = json.context?.solvingTypeName ?? "Unknown"
    }
    
}
