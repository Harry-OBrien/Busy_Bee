//
//  Busy_BeeApp.swift
//  Busy_Bee
//
//  Created by Harry O'Brien on 16/04/2022.
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
