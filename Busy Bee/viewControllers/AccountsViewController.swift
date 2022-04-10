////
////  AccountsViewController.swift
////  Busy Bee
////
////  Created by Harry O'Brien on 11/04/2022.
////
//
//import Preferences
//import SwiftUI
//
///**
//Function wrapping SwiftUI into `PreferencePane`, which is mimicking view controller's default construction syntax.
//*/
//func AccountsPreferenceViewController(delegate: AccountSettingsDelegate) -> PreferencePane {
//    /// Wrap your custom view into `Preferences.Pane`, while providing necessary toolbar info.
//    let paneView = Preferences.Pane(
//        identifier: .accounts,
//        title: "Accounts",
//        toolbarIcon: NSImage(systemSymbolName: "person.crop.circle", accessibilityDescription: "Accounts preferences")!
//    ) {
//        AccountsView(delegate)
//    }
//
//    return Preferences.PaneHostingController(pane: paneView)
//}
