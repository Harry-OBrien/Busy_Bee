//
//  User.swift
//  Busy Bee
//
//  Created by Harry O'Brien on 27/10/2024.
//

import Foundation
import FirebaseFirestore

struct User: Identifiable, Codable {
    @DocumentID var id: String? // Firestore document ID
    var name: String
    var status: WorkStatus
    var group_id: String

    enum WorkStatus: Int, Codable {
        case FREE = 0
        case WORKING = 1
        case DO_NOT_DISTURB = 2
        case PUB = 3
        case IDLE = 4

        func toString() -> String {
            switch self {
            case .FREE:
                return "Free"
            case .WORKING:
                return "Working"
            case .DO_NOT_DISTURB:
                return "Busy"
            case .PUB:
                return "Pub"
            case .IDLE:
                return "Offline"
            }
        }

        var iconName: String {
            switch self {
            case .FREE:
                return "bee_green"
            case .WORKING:
                return "bee_amber"
            case .DO_NOT_DISTURB:
                return "bee_red"
            case .PUB:
                return "bee_pub"
            case .IDLE:
                return "bee_black"
            }
        }

        var firestoreValue: Int {
            return self.rawValue
        }
    }
    
    // Firestore expects these keys to match your document structure
    enum CodingKeys: String, CodingKey {
        case name
        case status
        case group_id
    }
}
