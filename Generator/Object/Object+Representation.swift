//
//  Object+Representation.swift
//  Generator
//
//  Created by Artyom Mukha on 4/12/20.
//  Copyright © 2020 SFTNHRD. All rights reserved.
//

import Foundation

let singleIndent = "    "

let representationTemplate =
"""
struct %@ {
%@%@
%@}
"""

extension Object {

    var representation: String {
        representation(indent: "")
    }
}

// MARK: Private
private extension Object {

    func representation(indent: String) -> String {
        .init(
            format: representationTemplate,
            name,
            childrenRepresentation(indent: indent + singleIndent),
            propertiesRepresentation(indent: indent + singleIndent),
            indent
        )
    }

    func childrenRepresentation(indent: String) -> String {
        children.reduce("") { result, child in
            result + indent + child.representation(indent: indent) + "\n\n"
        }
    }

    func propertiesRepresentation(indent: String) -> String {
        properties.enumerated().reduce("") { result, enumeratedProperty in
            var partial = enumeratedProperty.element.representation(indent: indent)
            if enumeratedProperty.offset < properties.endIndex - 1 {
                partial += "\n"
            }
            return result + partial
        }
    }
}

extension Object.Property {

    func representation(indent: String) -> String {
        indent + "let " + name + ": " + type
    }
}
