//
//  Group.swift
//  Busy Bee
//
//  Created by Harry O'Brien on 27/10/2024.
//

import Foundation
import FirebaseFirestore

struct Group: Identifiable, Codable {
    @DocumentID var id: String?
    var group_id: String
    var name: String
    var members: [String] // List of user IDs (UIDs)
}
