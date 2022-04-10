//
//  AdvancedPreferencesViewController.swift
//  Busy Bee
//
//  Created by Harry O'Brien on 10/04/2022.
//

import SwiftUI
import Preferences

let DatabasePreferenceViewController: () -> PreferencePane = {
    let paneView = Preferences.Pane(
        identifier: .database,
        title: "Database",
        toolbarIcon: NSImage(systemSymbolName: "externaldrive.connected.to.line.below", accessibilityDescription: "Database management")!
    ) {
        DatabaseSettingsView()
    }
    
    return Preferences.PaneHostingController(pane: paneView)
}
