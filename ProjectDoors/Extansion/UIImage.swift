//
//  Image.swift
//  ProjectDoors
//
//  Created by Artem Manakov on 06.01.2023.
//

import Foundation
import UIKit

extension UIImage {
    static func getImageForCell(status: Status, leftImage: Bool) -> UIImage {
        switch status {
        case .locked:
            return leftImage ? UIImage(named: "LockedCellLeft")! : UIImage(named: "LockedCellRight")!
        case .unlocking:
            return leftImage ? UIImage(named: "UnlockingCellLeft")! : UIImage(named: "UnlockingCellRight")!
        case .unlocked:
            return leftImage ? UIImage(named: "UnlockedCellLeft")! : UIImage(named: "UnlockedCellRight")!
        }
    }
}
