//
//  MenuViewModel.swift
//  Busy_Bee
//
//  Created by Harry O'Brien on 16/04/2022.
//

import Foundation
import AppKit
import Firebase
import FirebaseDatabase

class MenuViewModel: ObservableObject {
    
    /*@Published*/
    private var _friends = [User]()
    var friends: [User]! {
        set {
            _friends = newValue.sorted(by: {$0.id < $1.id})
            redraw()
        }
        get {
            return _friends
        }
    }
    
    /*@Published*/
    var user: User! {
        didSet {
            if user.id != "NO_AUTH" {
                ref.child("users/\(user.id)/status").setValue(user.status.rawValue)
            }
        }
    }
    
    private static func get_user_id() -> String? {
        return UserDefaults.standard.string(forKey: "user_id")
    }
    /*@Published*/
    var loggedIn: Bool
    
    private let onUserStateUpdate: (NSImage)->()
    private let redraw: ()->()
    
    private let databaseURL = "https://busy-bee-480f7-default-rtdb.europe-west1.firebasedatabase.app/"
    private var refHandle: UInt!
    private var ref: DatabaseReference!
    
    init(update_user_icon: @escaping (NSImage)->(), redraw: @escaping ()->()) {
        loggedIn = true
        self.onUserStateUpdate = update_user_icon
        self.redraw = redraw
        
        // Firebase stuff!
        FirebaseApp.configure()
        ref = Database.database(url: databaseURL).reference()
        
        // Initial read
        ref.child("users").getData(completion: { error, snapshot in
            guard error == nil, let friend_list = snapshot.value as? [String: [String:Int]] else {
                print("Failed to parse data on first load")
                return
            }
            var updated_friends = [User]()
            for (friend, friend_status) in friend_list {
                if friend == self.user.id {
                    continue
                }
                
                let status = WorkStatus(rawValue: friend_status["status"]!) ?? WorkStatus.IDLE
                updated_friends.append(User(id: friend, status: status))
            }
            
            self.friends = updated_friends
        });
        
        // Live observation
        refHandle = ref.child("users").observe(.value, with: { snapshot in
            guard let friend_list = snapshot.value as? [String: [String:Int]] else {
                print("Failed to parse data on update")
                return
            }
            
            var updated_friends = [User]()
            for (friend, friend_status) in friend_list {
                if friend == self.user.id {
                    continue
                }
                
                let status = WorkStatus(rawValue: friend_status["status"]!) ?? WorkStatus.FREE
                updated_friends.append(User(id: friend, status: status))
            }
            
            self.friends = updated_friends
        })
        
        // Set initial state
        user = User(id: MenuViewModel.get_user_id() ?? "Anna", status: .FREE)
        onUserStateUpdate(icon(for: user))
    }
    
    func changeStatus(to newStatus: WorkStatus) {
        user.status = newStatus
        onUserStateUpdate(icon(for: user))
    }
    
    func icon(for friend: User) -> NSImage {
        var img: NSImage!
        switch friend.status {
        case .DO_NOT_DISTURB:
            img = NSImage(named: NSImage.Name("bee_red"))
        case .BUSY:
            img = NSImage(named: NSImage.Name("bee_amber"))
        case .FREE:
            img = NSImage(named: NSImage.Name("bee_green"))
        case .PUB:
            img = NSImage(named: NSImage.Name("bee_pub"))
        case .IDLE:
            img = NSImage(named: NSImage.Name("bee_black"))
        }
   
        
        img!.size = NSSize(width: 18, height: 18)
        return img
    }
}
