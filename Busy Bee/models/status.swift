//
//  status.swift
//  Busy Bee
//
//  Created by Harry O'Brien on 03/04/2022.
//

import Foundation

enum WorkStatus: Int, Codable {
    case FREE = 0
    case BUSY = 1
    case DO_NOT_DISTURB = 2
}
