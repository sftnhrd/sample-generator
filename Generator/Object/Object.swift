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
