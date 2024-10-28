//
//  MenuBarView.swift
//  Busy Bee
//
//  Created by Harry O'Brien on 27/10/2024.
//

import SwiftUI

struct MenuView: View {
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var groupViewModel: GroupViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Menu options to change the status
            Button("Free") {
                userViewModel.updateUserStatus(to: .FREE)
            }
            .keyboardShortcut("1")
            
            Button("Working") {
                userViewModel.updateUserStatus(to: .WORKING)
            }
            .keyboardShortcut("2")
            
            Button("Do Not Disturb") {
                userViewModel.updateUserStatus(to: .DO_NOT_DISTURB)
            }
            .keyboardShortcut("3")

            Button("Pub") {
                userViewModel.updateUserStatus(to: .PUB)
            }
            .keyboardShortcut("4")

            Divider()

            // List of group members and their statuses
            VStack(alignment: .leading, spacing: 0) {
                ForEach(groupViewModel.members) { member in
                    Label(member.name, image: member.status.iconName)
                        .labelStyle(.titleAndIcon)
                }
            }

            Divider()

            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut("q")
        }
        .padding(.horizontal, 10) // Additional padding to make the layout comfortable
        .frame(width: 200) // Explicit width to avoid resizing issues in MenuBarExtra
        .onAppear {
            if let user = userViewModel.user {
                groupViewModel.fetchGroup(by: user.group_id, excluding: user.id!)
            }
        }
        .onAppear {
            NotificationCenter.default.addObserver(
                forName: NSWindow.didChangeOcclusionStateNotification, object: nil, queue: nil)
            { notification in
                let visible = (notification.object as! NSWindow).isVisible
                
                if visible, let user = userViewModel.user {
                    groupViewModel.fetchGroup(by: user.group_id, excluding: user.id!)
                }
            }
        }
    }
}
