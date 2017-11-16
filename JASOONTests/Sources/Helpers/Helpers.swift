//
//  Helpers.swift
//  JASON
//
//  Created by Julian Parkfy on 21/3/17.
//  Copyright © 2017 Julian. All rights reserved.
//

import Foundation

extension String {
    var data: Data {
        let bundle = Bundle(for: Reference.self)
        let url = bundle.url(forResource: self, withExtension: ".json")!
        return try! Data(contentsOf: url)
    }
}



private final class Reference {}
