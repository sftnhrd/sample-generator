//
//  Generator.swift
//  Generator
//
//  Created by Artyom Mukha on 4/12/20.
//  Copyright © 2020 SFTNHRD. All rights reserved.
//

import Foundation

struct Generator {
    let lines: [String]
}

extension Generator {

    func generateSamples() -> [String] {
        let objects = makeObjects()
        return objects.map { $0.sample }
    }
}

private extension Generator {

    func makeObjects() -> [Object] {
        var objects = [Object]()
        var currentObject: Object?
        var isEnum = false

        lines.forEach { line in
            let line = Line(rawValue: line)

            switch line.type {

            case .nothing:
                break

            case let .type(name):
                let object = Object(name: name, parent: currentObject)
                if let currentObject = currentObject {
                    currentObject.children.append(object)
                } else {
                    objects.append(object)
                }
                currentObject = object

            case .typeEnum:
                isEnum = true

            case let .property(property):
                currentObject?.properties.append(property)

            case .typeEnd:
                if isEnum {
                    isEnum = false
                } else {
                    currentObject = currentObject?.parent
                }
            }
        }

        return objects
    }
}
