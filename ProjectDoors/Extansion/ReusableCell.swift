//
//  ReusableCell.swift
//  ProjectDoors
//
//  Created by Artem Manakov on 05.01.2023.
//

import Foundation
import UIKit

protocol ReusableCell: AnyObject {
    static var cellID: String { get }
}

extension ReusableCell where Self: UIView {
    static var cellID: String {
        return NSStringFromClass(self)
    }
}
