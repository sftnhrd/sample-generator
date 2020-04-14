//
//  AppDelegate.swift
//  SampleGenerator
//
//  Created by Artyom Mukha on 4/11/20.
//  Copyright © 2020 SFTNHRD. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }
}
