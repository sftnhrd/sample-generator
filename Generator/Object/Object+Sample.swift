//
//  Object+Sample.swift
//  Generator
//
//  Created by Artyom Mukha on 4/12/20.
//  Copyright © 2020 SFTNHRD. All rights reserved.
//

import Foundation

let sampleTemplate =
"""

extension %@ {

    static func sample(
%@
    ) -> Self {
        .init(
%@
        )
    }
}
%@
"""

let defaultValue = " = <#default value" + "#" + ">"

let escaping = "@escaping "

extension Object {

    var sample: String {
        sample(keyPath: "")
    }
}

// MARK: Private
private extension Object {

    func sample(keyPath: String) -> String {
        .init(
            format: sampleTemplate,
            keyPath + name,
            arguments,
            body,
            childrenSamples(keyPath: keyPath + name + ".")
        )
    }

    var arguments: String {
        properties.enumerated().reduce("") { result, enumeratedProperty in
            var partial = enumeratedProperty.element.argument
            if enumeratedProperty.offset < properties.endIndex - 1 {
                partial += ",\n"
            }
            return result + partial
        }
    }

    var body: String {
        properties.enumerated().reduce("") { result, enumeratedProperty in
            var partial = enumeratedProperty.element.body
            if enumeratedProperty.offset < properties.endIndex - 1 {
                partial += ",\n"
            }
            return result + partial
        }
    }

    func childrenSamples(keyPath: String) -> String {
        children.reduce("") { result, child in
            result + child.sample(keyPath: keyPath)
        }
    }
}

extension Object.Property {

    var argument: String {
        String(repeating: singleIndent, count: 2) + name + ": " + argumentType + defaultValue
    }

    var body: String {
        String(repeating: singleIndent, count: 3) + name + ": " + name
    }

    private var argumentType: String {
        guard isClosure else { return type }
        return escaping + type
    }
}
