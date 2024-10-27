//
//  Menu.swift
//  Busy_Bee
//
//  Created by Harry O'Brien on 16/04/2022.
//

import Foundation
import AppKit
import SwiftUI

class BusyBeeMenu: NSMenu {
    
    @ObservedObject var view_model: MenuViewModel
    
    init(view_model: MenuViewModel) {
        self.view_model = view_model
        super.init(title: "")
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func build() {
        action_items.forEach({
            addItem($0)
            $0.target = self
        })
        addSeperator()
        
//        let menu_items = view_model.loggedIn ? logged_in_items : logged_out_items
        let menu_items = logged_in_items;
        
        menu_items.forEach({addItem($0)})
        addSeperator()
        
        addItem(preferencesItem)
        addItem(aboutItem)
        addSeperator()
        
        addItem(quitItem)
    }
    
    private let action_items: [NSMenuItem] = [
        NSMenuItem(title: "Available", action: #selector(didTapFree) , keyEquivalent: "1"),
        NSMenuItem(title: "Busy", action: #selector(didTapBusy) , keyEquivalent: "2"),
        NSMenuItem(title: "Do not disturb", action: #selector(didTapDND) , keyEquivalent: "3"),
        NSMenuItem(title: "Pub?", action: #selector(didTapPub) , keyEquivalent: "4"),
    ]
    
    private var logged_in_items: [NSMenuItem] {
        var items = [NSMenuItem]()
        for friend in view_model.friends {
            let friendItem = NSMenuItem(
                title: friend.id,
                action: nil,
                keyEquivalent: ""
            )
            friendItem.image = view_model.icon(for: friend)
            items.append(friendItem)
        }
        
        return items
    }
    
    private let logged_out_items = [
        NSMenuItem(
            title: "Login",
            action: #selector(didTapPreferences),
            keyEquivalent: ""),
    ]
    
    private var preferencesItem:NSMenuItem {
        let item = NSMenuItem (
            title: "Preferences",
            action: #selector(didTapPreferences),
            keyEquivalent: ",")
        
        item.target = self
        return item
    }
    
    private var aboutItem: NSMenuItem {
        let item = NSMenuItem(
            title: "About Busy Bee",
            action: #selector(didTapAbout(_:)),
            keyEquivalent: "")
        item.target = self
        return item
    }
        
    private let quitItem = NSMenuItem(
        title: "Quit",
        action: #selector(NSApplication.terminate(_:)),
        keyEquivalent: "q"
    )
    
    private func addSeperator() {
        addItem(NSMenuItem.separator())
    }
    
    // MARK: Did Tap Functions
    @objc func didTapAbout(_ sender: NSMenuItem) {
        NSApp.orderFrontStandardAboutPanel()
    }
    
    @objc func didTapPub() {
        view_model.changeStatus(to: .PUB)
    }
    
    @objc func didTapFree() {
        view_model.changeStatus(to: .FREE)
    }
    
    @objc func didTapBusy() {
        view_model.changeStatus(to: .BUSY)
    }
    
    @objc func didTapDND() {
        view_model.changeStatus(to: .DO_NOT_DISTURB)
    }
    
    @objc func didTapPreferences() {
        
    }
}
