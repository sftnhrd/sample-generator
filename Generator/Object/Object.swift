//
//  Property.swift
//  Generator
//
//  Created by Artyom Mukha on 4/11/20.
//  Copyright © 2020 SFTNHRD. All rights reserved.
//

import Foundation

final class Object {

    struct Property {
        let name: String
        let type: String
    }

    let name: String
    private(set) weak var parent: Object?
    var properties = [Property]()
    var children = [Object]()

    init(name: String, parent: Object?) {
        self.name = name
        self.parent = parent
    }
}

extension Object.Property {

    private enum Constants {
        static let closureRegex = try? NSRegularExpression(pattern: "->", options: [])
    }

    var isClosure: Bool {
        Constants.closureRegex?.firstMatch(
            in: type,
            options: [],
            range: NSRange(location: 0, length: (type as NSString).length)
        ) != nil
    }
}
