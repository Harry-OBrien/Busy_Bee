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
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}
