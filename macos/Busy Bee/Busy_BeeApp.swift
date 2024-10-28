//
//  Busy_BeeApp.swift
//  Busy Bee
//
//  Created by Harry O'Brien on 27/10/2024.
//

import SwiftUI
import Firebase

@main
struct Busy_BeeApp: App {
    
    init() {
        FirebaseApp.configure();
    }
    
    @StateObject private var userViewModel = UserViewModel()
    @StateObject private var groupViewModel = GroupViewModel()
    
    
    var body: some Scene {
        MenuBarExtra(userViewModel.statusText, image: userViewModel.statusIcon) {
            MenuView(userViewModel: userViewModel, groupViewModel: groupViewModel)
        }
    }
}
