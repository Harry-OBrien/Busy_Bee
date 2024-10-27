//
//  friends.swift
//  Busy Bee
//
//  Created by Harry O'Brien on 03/04/2022.
//

import Foundation;

func getMockFriends() -> [User] {
    return [
        User(id: "Alice",       status: .FREE),
        User(id: "Bob",         status: .FREE),
        User(id: "Claire",      status: .BUSY),
        User(id: "Dinglebat",   status: .DO_NOT_DISTURB),
        User(id: "Echious",     status: .PUB),
        User(id: "Francesca",   status: .FREE),
    ]
}

struct User: Identifiable, Codable {
    let id: String
    var status: WorkStatus
}
