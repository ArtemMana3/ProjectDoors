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
            if leftImage {
                return UIImage(named: "LockedCellLeft") ?? UIImage.checkmark
            } else {
                return UIImage(named: "LockedCellRight") ?? UIImage.checkmark
            }
        case .unlocking:
            if leftImage {
                return UIImage(named: "UnlockingCellLeft") ?? UIImage.checkmark
            } else {
                return UIImage(named: "UnlockingCellRight") ?? UIImage.checkmark
            }
        case .unlocked:
            if leftImage {
                return UIImage(named: "UnlockedCellLeft") ?? UIImage.checkmark
            } else {
                return UIImage(named: "UnlockedCellRight") ?? UIImage.checkmark
            }
        }
    }
}
