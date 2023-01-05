//
//  Color + Image.swift
//  ProjectDoors
//
//  Created by Artem Manakov on 05.01.2023.
//

import Foundation
import UIKit

extension UIColor {
    static let customLightGray = UIColor(red: 0.882, green: 0.91, blue: 0.91, alpha: 1)
    static let customDarkBlue =  UIColor(red: 0.196, green: 0.216, blue: 0.333, alpha: 1)
    
    static func getStatusLableColor(status: Status) -> UIColor {
        switch status {
        case .locked:
            return UIColor(red: 0, green: 0.267, blue: 0.545, alpha: 1)
        case .unlocking:
            return UIColor(red: 0, green: 0, blue: 0, alpha: 0.17)
        case .unlocked:
            return UIColor(red: 0, green: 0.267, blue: 0.545, alpha: 0.5)
        }
    }
}
