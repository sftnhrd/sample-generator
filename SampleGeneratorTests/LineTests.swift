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

        guard case .property = line.type else {
            return XCTAssert(false)
        }

        XCTAssert(true)
    }

    func testClosureProperty() {
        let line = Line(rawValue: "let closure: (String) -> Void")
        guard
            case let .property(property) = line.type,
            property.isClosure
        else {
            return XCTAssert(false)
        }

        XCTAssert(true)
    }

    func testClosurePropertyArgument() {
        let property = Object.Property(name: "closure", type: "() -> Void")

        let argument = property.argument
        XCTAssertEqual(argument, "        closure: @escaping () -> Void = <#default value#>")
    }
}
