//
//  Line.swift
//  Generator
//
//  Created by Artyom Mukha on 4/12/20.
//  Copyright © 2020 SFTNHRD. All rights reserved.
//

import Foundation

let supportedTypes = ["struct", "class"]
let enumType = "enum"
let propertyTypes = ["let", "var"]
let endOfObject = "}"

struct Line {
    let rawValue: String
}

extension Line {

    enum `Type` {
        case nothing
        case type(String)
        case typeEnum
        case property(Object.Property)
        case typeEnd
    }

    var type: Type {
        let trimmed = rawValue.trimmingCharacters(in: .whitespacesAndNewlines)
        return findType(trimmed)
    }
}

private extension Line {

    func findType(_ line: String) -> Type {
        if let name = findObjectName(line) { return .type(name) }

        if containsEnum(line) { return .typeEnum }

        if let property = findProperty(line) { return .property(property) }

        if containsEndOfObject(line) { return .typeEnd }

        return .nothing
    }

    func findObjectName(_ line: String) -> String? {
        let words = findWords(line)

        var hasName = false

        return words.first { word -> Bool in
            if hasName { return true }
            hasName = supportedTypes.contains(word)
            return false
        }
    }

    func containsEnum(_ line: String) -> Bool {
        let words = findWords(line)
        return words.contains(enumType)
    }

    func findProperty(_ line: String) -> Object.Property? {
        let words = findWords(line)

        guard
            let index = words.firstIndex(where: { propertyTypes.contains($0) }),
            words.count == index + 3
        else { return nil }

        let name = words[index + 1]
        let type = words[index + 2]

        return .init(name: name, type: type)
    }

    func containsEndOfObject(_ line: String) -> Bool {
        line.contains(endOfObject)
    }

    func findWords(_ line: String) -> [String] {
        let set = CharacterSet(charactersIn: ":").union(.whitespaces)
        return line.components(separatedBy: set).filter { !$0.isEmpty }
    }
}
