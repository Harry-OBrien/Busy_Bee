//
//  friends.swift
//  Busy Bee
//
//  Created by Harry O'Brien on 03/04/2022.
//

struct User: Identifiable, Codable {
    let id: String
    var status: WorkStatus
}
