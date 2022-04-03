//
//  Busy_BeeApp.swift
//  Busy Bee
//
//  Created by Harry O'Brien on 03/04/2022.
//

import Cocoa
import SwiftUI

@main
struct Busy_BeeApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {Settings {EmptyView()}}
}

// Our AppDelegae will handle our menu
class AppDelegate: NSObject, NSApplicationDelegate {
    static private(set) var instance: AppDelegate!
    var statusItem: NSStatusItem!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: 18)
        statusItem.button!.image = NSImage(named: NSImage.Name("bee_green"))
        statusItem.button!.image!.size = NSSize(width: 18, height: 18)
        statusItem.button?.imagePosition = .imageLeading
        setupMenus()
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    private func icon_for(_ status: WorkStatus) -> NSImage? {
        var img: NSImage?
        switch status {
        case .DO_NOT_DISTURB:
            img = NSImage(named: NSImage.Name("bee_red"))
        case .BUSY:
            img = NSImage(named: NSImage.Name("bee_amber"))
        case .FREE:
            img = NSImage(named: NSImage.Name("bee_green"))
        }
        if let img = img {
            img.size = NSSize(width: 18, height: 18)
        }
        
        return img
    }
    
    func setupMenus() {
        let menu = NSMenu()
        
        /* * OUR STATUS * */
        let free = NSMenuItem(title: "Available", action: #selector(didTapFree) , keyEquivalent: "1")
        let busy = NSMenuItem(title: "Busy", action: #selector(didTapBusy) , keyEquivalent: "2")
        let dnd = NSMenuItem(title: "Do not disturb", action: #selector(didTapDND) , keyEquivalent: "3")
        
        menu.addItem(free)
        menu.addItem(busy)
        menu.addItem(dnd)
        menu.addItem(NSMenuItem.separator())
        
        /* * FRIENDS * */
        for friend in mockFriends.sorted(by: {$0.name < $1.name}) {
            let menuItem = NSMenuItem(
                title: friend.name,
                action: nil,
                keyEquivalent: ""
            )
            menuItem.image = icon_for(friend.status)
            menu.addItem(menuItem)
        }
        menu.addItem(NSMenuItem.separator())
        
        /* * PREFERENCES * */
        let preferencesMenuItem = NSMenuItem(
            title: "Preferences",
            action: #selector(about),
            keyEquivalent: ","
        )
        preferencesMenuItem.target = self
        menu.addItem(preferencesMenuItem)
        
        /* * ABOUT * */
        let aboutMenuItem = NSMenuItem(
            title: "About Busy Bee",
            action: #selector(about),
            keyEquivalent: ""
        )
        aboutMenuItem.target = self
        menu.addItem(aboutMenuItem)
        menu.addItem(NSMenuItem.separator())
        
        /* * QUIT * */
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        statusItem.menu = menu
    }
    
    private func changeStatusBarButton(status: WorkStatus) {
        if let button = statusItem.button {
            button.image = icon_for(status)
        }
    }
    
    @objc func didTapDND() {
        changeStatusBarButton(status: .DO_NOT_DISTURB)
    }
    
    @objc func didTapBusy() {
        changeStatusBarButton(status: .BUSY)
    }
    
    @objc func didTapFree() {
        changeStatusBarButton(status: .FREE)
    }
    
    @objc func about(sender: NSMenuItem) {
        NSApp.orderFrontStandardAboutPanel()
    }
}
