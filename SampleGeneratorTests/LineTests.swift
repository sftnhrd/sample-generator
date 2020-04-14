//
//  SampleGeneratorTests.swift
//  SampleGeneratorTests
//
//  Created by Artyom Mukha on 4/13/20.
//  Copyright © 2020 SFTNHRD. All rights reserved.
//

import XCTest

class SampleGeneratorTests: XCTestCase {

    func testPrivateProperty() {
        let line = Line(rawValue: "private let identifier: String")
        if case .property = line.type {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }

    }
}
