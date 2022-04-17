//
//  AppDelegate.swift
//  Busy_Bee
//
//  Created by Harry O'Brien on 16/04/2022.
//

import Foundation
import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
//    let updateWindow = UpdateWindow()
    static private(set) var instance: AppDelegate!
    
    private var statusItem: NSStatusItem!
    private var menu: BusyBeeMenu!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        menu = BusyBeeMenu(view_model: MenuViewModel(update_user_icon: self.update_user_icon, redraw: redraw_menu))
        
        statusItem.menu = menu
        menu.build()
    }
    
    func update_user_icon(_ new_icon: NSImage) {
        if let button = statusItem.button {
            button.image = new_icon
        }
    }
    
    func redraw_menu() {
        menu.removeAllItems()
        menu.build()
    }
}
