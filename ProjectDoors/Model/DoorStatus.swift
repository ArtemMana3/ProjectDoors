//
//  ConditionDoor.swift
//  ProjectDoors
//
//  Created by Artem Manakov on 05.01.2023.
//

import Foundation
import UIKit

enum Status {
    case locked
    case unlocking
    case unlocked
}

class DoorStatus {
    let imageLeft: UIImage
    let imageRight: UIImage
    let status: String
    
    convenience init(status: Status) {
        switch status {
        case .locked:
            self.init(imageLeft: UIImage(named: "LockedCellLeft")!, //??????
                       imageRight: UIImage(named: "LockedCellRight")!, //??????
                       status: "Locked")
        case .unlocking:
            self.init(imageLeft: UIImage(named: "UnlockingCellLeft")!, //??????
                       imageRight: UIImage(named: "UnlockingCellRight")!, //??????
                       status: "Unlocking")
        case .unlocked:
            self.init(imageLeft: UIImage(named: "UnlockedCellLeft")!, //??????
                       imageRight: UIImage(named: "UnlockedCellRight")!, //??????
                       status: "Unlocked")
        }
    }
    
    init(imageLeft: UIImage, imageRight: UIImage, status: String) {
        self.imageLeft = imageLeft
        self.imageRight = imageRight
        self.status = status
    }
}

//struct DoorStatusFactory {
//    func chooseStatus(_ status: Status) -> DoorStatus{
//        switch status {
//        case .locked:
//            return DoorStatus(imageLeft: UIImage(named: "LockedCellLeft")!, //??????
//                              imageRight: UIImage(named: "LockedCellRight")!, //??????
//                              status: "Locked")
//        case .unlocking:
//            return DoorStatus(imageLeft: UIImage(named: "UnlockingCellLeft")!, //??????
//                              imageRight: UIImage(named: "UnlockingCellRight")!, //??????
//                              status: "Unlocking")
//        case .unlocked:
//            return DoorStatus(imageLeft: UIImage(named: "UnlockedCellLeft")!, //??????
//                              imageRight: UIImage(named: "UnlockedCellRight")!, //??????
//                              status: "Unlocked")
//        }
//    }
//}
