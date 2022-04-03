//
//  friends.swift
//  Busy Bee
//
//  Created by Harry O'Brien on 03/04/2022.
//

struct Friend: Identifiable {
    private(set) var id: Int
    
    let name: String
    let status: WorkStatus
}

var mockFriends: [Friend] {
    [
        Friend(id: 0, name: "Alice", status: .FREE),
        Friend(id: 1, name: "Kamil", status: .BUSY),
        Friend(id: 2, name: "Chelsea", status: .BUSY),
        Friend(id: 3, name: "Amber", status: .DO_NOT_DISTURB),
    ].sorted(by: {$0.name < $1.name})
}
