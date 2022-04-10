//
//  friends.swift
//  Busy Bee
//
//  Created by Harry O'Brien on 03/04/2022.
//

struct User: Identifiable, Codable {
    private(set) var id: String
    let status: WorkStatus
}
