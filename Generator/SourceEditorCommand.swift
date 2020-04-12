//
//  SourceEditorCommand.swift
//  Generator
//
//  Created by Artyom Mukha on 4/11/20.
//  Copyright © 2020 SFTNHRD. All rights reserved.
//

import Foundation
import XcodeKit

final class SourceEditorCommand: NSObject, XCSourceEditorCommand {

    enum Error: Swift.Error {
        case linesWrongObject
    }

    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Swift.Error?) -> Void ) -> Void {

        guard let lines = invocation.buffer.lines as? [String] else {
            return completionHandler(Error.linesWrongObject)
        }

        let generator = Generator(lines: lines)
        let samples = generator.generateSamples()

        samples.forEach { sample in
            invocation.buffer.lines.add(sample)
        }

        completionHandler(nil)
    }
}
