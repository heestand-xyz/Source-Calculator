//
//  AppDelegate.swift
//  Source Calculator
//
//  Created by Anton Heestand on 2019-12-04.
//  Copyright © 2019 Hexagons. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Create the window and set the content view. 
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
        

        if let mainMenu = NSApplication.shared.mainMenu {
            if let formatMenu = mainMenu.item(withTitle: "Format") {
                mainMenu.removeItem(formatMenu)
            }
            if let formatMenu = mainMenu.item(withTitle: "Edit") {
                mainMenu.removeItem(formatMenu)
            }
            if let formatMenu = mainMenu.item(withTitle: "View") {
                mainMenu.removeItem(formatMenu)
            }
            if let fileMenu = mainMenu.item(withTitle: "File")?.submenu {
                if let pageSetupMenuItem = fileMenu.item(withTitle: "Page Setup…") {
                    fileMenu.removeItem(pageSetupMenuItem)
                }
                if let printMenuItem = fileMenu.item(withTitle: "Print…") {
                    fileMenu.removeItem(printMenuItem)
                }
                if let printMenuItem = fileMenu.item(withTitle: "New") {
                    fileMenu.removeItem(printMenuItem)
                }
                if let printMenuItem = fileMenu.item(withTitle: "Open…") {
                    fileMenu.removeItem(printMenuItem)
                }
                if let printMenuItem = fileMenu.item(withTitle: "Save…") {
                    fileMenu.removeItem(printMenuItem)
                }
                if let printMenuItem = fileMenu.item(withTitle: "Save As…") {
                    fileMenu.removeItem(printMenuItem)
                }
                if let printMenuItem = fileMenu.item(withTitle: "Open Recent") {
                    fileMenu.removeItem(printMenuItem)
                }
            }
        }

    }

    func applicationWillTerminate(_ aNotification: Notification) {}

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }
    
}

