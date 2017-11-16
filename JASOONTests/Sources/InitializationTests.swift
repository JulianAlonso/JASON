//
//  InitializationTests.swift
//  JASON
//
//  Created by Julian Parkfy on 21/3/17.
//  Copyright © 2017 Julian. All rights reserved.
//

import XCTest
@testable import JASOON

final class InitializationTest: XCTest {
    
    func testInitNotNullWithData() {
        let data = "Object".data
        do {
            let json = try JSON(data)
            
            XCTAssertEqual(json[Parsed.Fields.bool] as? Bool, Parsed.Values.bool)
            XCTAssertEqual(json[Parsed.Fields.string] as? String, Parsed.Values.string)
            XCTAssertEqual(json[Parsed.Fields.int] as? Int, Parsed.Values.int)
            XCTAssertNil(json[Parsed.Fields.null])
            
        } catch {
            XCTFail("Not expected error: \(error)")
        }
    }
    
}
