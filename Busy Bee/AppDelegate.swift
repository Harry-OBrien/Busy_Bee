//
//  AppDelegate.swift
//  Busy Bee
//
//  Created by Harry O'Brien on 11/04/2022.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseDatabase
//import Preferences

// Our AppDelegate will handle our menu
class AppDelegate: NSObject, NSApplicationDelegate {
    static private(set) var instance: AppDelegate!
    
    private var statusItem: NSStatusItem!
    private var ref: DatabaseReference!
    private var _friends = [User]()
    private var friends: [User] {
        set {
            _friends = newValue.sorted(by: {$0.id < $1.id})
            self.setupMenus()
        }
        get {
            return _friends
        }
    }
    private var user: User!
    private let defaults = UserDefaults.standard
    private let databaseURL = "https://busy-bee-480f7-default-rtdb.europe-west1.firebasedatabase.app/"
    private var refHandle: UInt!
    private var menu = NSMenu()
    
    // User deets
    private var user_id: String? {
        set {
            defaults.set(newValue, forKey: "user_id")
            
            // TODO: Update firebase
        }
        get {
            defaults.string(forKey: "user_id")
        }
    }
    
    private var user_status: WorkStatus {
        set {
            defaults.set(newValue.rawValue, forKey: "user_status")
            changeStatusBarButton(status: newValue)
            
            if let user_id = user_id {
                ref.child("users/\(user_id)/status").setValue(newValue.rawValue)
            }
        }
        get {
            return defaults.object(forKey: "user_status") as! WorkStatus
        }
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        FirebaseApp.configure()
        ref = Database.database(url: databaseURL).reference()
        
        // TODO: Actually store user data here instead of just default value
        user_id = "Alice"
        
        statusItem = NSStatusBar.system.statusItem(withLength: 18)
        user_status = .FREE
        
        // get friend deets
        refHandle = ref.child("users").observe(.value, with: { snapshot in
            guard let friend_list = snapshot.value as? [String: [String:Int]] else {
                print("Failed to parse data :(")
                return
            }
            
            var updated_friends = [User]()
            let our_id = self.user_id
            for (friend, friend_status) in friend_list {
                if friend == our_id {
                    continue
                }
                
                if let status = WorkStatus(rawValue: friend_status["status"]!) {
                    updated_friends.append(User(id: friend, status: status))
                }
            }
            
            self.friends = updated_friends
        })
        
        setupMenus()
//        fixFirstTimeLanuchOddAnimationByImplicitlyShowIt()
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
//    private func fixFirstTimeLanuchOddAnimationByImplicitlyShowIt() {
//        preferencesWindowController.show(preferencePane: .accounts)
//        preferencesWindowController.close()
//    }
    
    private func setupMenus() {
        menu.removeAllItems()
        
        /* * OUR STATUS * */
        if user_id != nil {
            let free = NSMenuItem(title: "Available", action: #selector(didTapFree) , keyEquivalent: "1")
            let busy = NSMenuItem(title: "Busy", action: #selector(didTapBusy) , keyEquivalent: "2")
            let dnd = NSMenuItem(title: "Do not disturb", action: #selector(didTapDND) , keyEquivalent: "3")
            
            menu.addItem(free)
            menu.addItem(busy)
            menu.addItem(dnd)
        }
        else {
            let not_set_item = NSMenuItem(title: "No name set", action: nil, keyEquivalent: "")
            menu.addItem(not_set_item)
        }
        menu.addItem(NSMenuItem.separator())
        
        /* * FRIENDS * */
        for friend in friends {
            let menuItem = NSMenuItem(
                title: friend.id,
                action: nil,
                keyEquivalent: ""
            )
            menuItem.image = icon_for(friend.status)
            menu.addItem(menuItem)
        }
        
        if friends.isEmpty {
            let menuItem = NSMenuItem(
                title: "No friends were loaded :(",
                action: nil,
                keyEquivalent: ""
            )
            menu.addItem(menuItem)
        }
        
        menu.addItem(NSMenuItem.separator())
        
        /* * PREFERENCES * */
//        let preferencesMenuItem = NSMenuItem(
//            title: "Preferences",
//            action: #selector(open_preferences),
//            keyEquivalent: ","
//        )
//        preferencesMenuItem.target = self
//        menu.addItem(preferencesMenuItem)
        
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
    
    private func icon_for(_ status: WorkStatus) -> NSImage {
        var img: NSImage!
        switch status {
        case .DO_NOT_DISTURB:
            img = NSImage(named: NSImage.Name("bee_red"))
        case .BUSY:
            img = NSImage(named: NSImage.Name("bee_amber"))
        case .FREE:
            img = NSImage(named: NSImage.Name("bee_green"))
        }
        
        img!.size = NSSize(width: 18, height: 18)
        return img
    }
    
    private func changeStatusBarButton(status: WorkStatus) {
        if let button = statusItem.button {
            button.image = icon_for(status)
        }
    }
    
    @objc func didTapDND() {
        user_status = .DO_NOT_DISTURB
    }
    
    @objc func didTapBusy() {
        user_status = .BUSY
    }
    
    @objc func didTapFree() {
        user_status = .FREE
    }
    
    @objc func about(sender: NSMenuItem) {
        NSApp.orderFrontStandardAboutPanel()
    }
    
    // MARK: Preferences
    
//    private lazy var preferences: [PreferencePane] = [
//        AccountsPreferenceViewController()
//    ]
//
//    private lazy var preferencesWindowController = PreferencesWindowController(
//        preferencePanes: preferences,
//        style: .toolbarItems,
//        animated: true,
//        hidesToolbarForSingleItem: true
//    )
//
//    @objc func open_preferences() {
//        preferencesWindowController.show(preferencePane: .accounts)
//    }
}
