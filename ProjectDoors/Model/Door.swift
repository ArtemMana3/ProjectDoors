//
//  Door.swift
//  ProjectDoors
//
//  Created by Artem Manakov on 05.01.2023.
//

import Foundation
import UIKit

struct Door {
    let name: String
    let type: String
    var status: Status
}

enum Status: String {
    case locked
    case unlocking
    case unlocked
    
    var oppositeStatus: Status {
        switch self {
        case .locked:
            return .unlocked
        case .unlocked:
            return .locked
        case .unlocking:
            return .unlocking
        }
    }
}
