//
//  DoorCell.swift
//  ProjectDoors
//
//  Created by Artem Manakov on 04.01.2023.
//

import UIKit
import SnapKit

class DoorCell: UITableViewCell {
    static let identifier: String = "DoorCell"
    var door = Door(name: "Unknown", type: "Unknown", status: .init(status: .locked))
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(door: Door) {
        imageLeft.image = door.status.imageLeft
        imageRight.image = door.status.imageRight
        doorName.text = door.name
        doorType.text = door.type
        doorCondition.text = door.status.status
    }
    
    lazy var view: UIView = {
        let view = UIView(frame: CGRect(x: 15, y: 0, width: UIScreen.main.bounds.width - 30, height: 115))
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 13
        view.layer.borderColor = UIColor(red: 0.89, green: 0.918, blue: 0.918, alpha: 1).cgColor
        
        addSubview(view)
        return view
    }()

    lazy var imageLeft: UIImageView = {
        let imageView = UIImageView(image: door.status.imageLeft)
        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(imageView)
        return imageView
    }()
    
    lazy var imageRight: UIImageView = {
        let imageView = UIImageView(image: door.status.imageRight)
        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(imageView)
        return imageView
    }()

    lazy var doorName: UILabel = {
        let lbl = UILabel()
        lbl.text = door.name
        lbl.textColor = UIColor(red: 0.196, green: 0.216, blue: 0.333, alpha: 1)
        lbl.font = UIFont(name: "Sk-Modernist", size: 16.0)
        lbl.font = UIFont.boldSystemFont(ofSize: 16) // ?????

        view.addSubview(lbl)
        return lbl
    }()

    lazy var doorType: UILabel = {
        let lbl = UILabel()
        lbl.text = door.type
        lbl.textColor =  UIColor(red: 0.725, green: 0.725, blue: 0.725, alpha: 1)
        lbl.font = UIFont(name: "Sk-Modernist", size: 14.0)
        lbl.font = UIFont.systemFont(ofSize: 14) // ?????

        view.addSubview(lbl)
        return lbl
    }()

    lazy var doorCondition : UILabel = {
        let lbl = UILabel()
        lbl.text = door.status.status
        lbl.textColor =  UIColor(red: 0, green: 0.267, blue: 0.545, alpha: 1)
        lbl.font = UIFont(name: "Sk-Modernist", size: 15.0)
        lbl.font = UIFont.boldSystemFont(ofSize: 15) // ?????

        view.addSubview(lbl)
        return lbl
    }()
    
    
    func configure() {
        imageLeft.snp.makeConstraints { make in
            make.top.equalTo(18)
            make.leading.equalTo(27)
            make.width.height.equalTo(41)
        }
        
        imageRight.snp.makeConstraints { make in
            make.top.equalTo(18)
            make.trailing.equalTo(-28)
            make.width.equalTo(41)
            make.height.equalTo(45)
        }

        doorName.snp.makeConstraints { make in
            make.leading.equalTo(imageLeft.snp.trailing).inset(-14)
            make.top.equalTo(22)
        }

        doorType.snp.makeConstraints { make in
            make.top.equalTo(doorName.snp.bottom)
            make.leading.equalTo(imageLeft.snp.trailing).inset(-14)
        }

        doorCondition.snp.makeConstraints { make in
            make.top.equalTo(doorType.snp.bottom).inset(-27)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
}


//import UIKit
//import SnapKit
//
//class DoorCell: UITableViewCell {
//    static let identifier: String = "DoorCell"
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.configure()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
////    lazy var view: UIView = {
////        let view = UIView()
////        view.layer.borderWidth = 1
////        view.layer.borderColor = UIColor.gray.cgColor
////        view.layer.cornerRadius = 13
////        return view
////    }()
//
//    lazy var image1: UIImageView = {
//        let image = UIImage(named: "ClosingDoorLeft")
//        let imageView = UIImageView(image: image)
//        imageView.contentMode = .scaleAspectFit
//        self.contentView.addSubview(imageView)
//        return imageView
//    }()
//
//    lazy var doorName: UILabel = {
//        let lbl = UILabel()
//        //      lbl.numberOfLines = 1
//        lbl.text = "Front door"
//        lbl.textColor = UIColor(red: 0.196, green: 0.216, blue: 0.333, alpha: 1)
//        lbl.font = UIFont(name: "Sk-Modernist", size: 16.0)
//        lbl.font = UIFont.boldSystemFont(ofSize: 16) // ?????
//
//        self.contentView.addSubview(lbl)
//        return lbl
//    }()
//
//    lazy var doorType: UILabel = {
//        let lbl = UILabel()
//        lbl.text = "Office"
//        lbl.textColor =  UIColor(red: 0.725, green: 0.725, blue: 0.725, alpha: 1)
//        lbl.font = UIFont(name: "Sk-Modernist", size: 14.0)
//        lbl.font = UIFont.systemFont(ofSize: 14) // ?????
//
//        self.contentView.addSubview(lbl)
//        return lbl
//    }()
//
//    lazy var doorCondition : UILabel = {
//        let lbl = UILabel()
//        lbl.text = "Locked"
//        lbl.textColor =  UIColor(red: 0, green: 0.267, blue: 0.545, alpha: 1)
//        lbl.font = UIFont(name: "Sk-Modernist", size: 15.0)
//        lbl.font = UIFont.systemFont(ofSize: 15) // ?????
//
//        self.contentView.addSubview(lbl)
//        return lbl
//    }()
//
//    func configure() {
//
//        self.contentView.snp.makeConstraints { make in
//            make.leading.equalTo(15)
//            make.trailing.equalTo(-15)
//            make.height.equalTo(115)
//            make.bottom.equalTo(15)
////            make.top.equalTo(15)
//
//        }
//        self.contentView.layer.cornerRadius = 13
//        self.contentView.layer.borderWidth = 1
//        self.contentView.layer.borderColor = UIColor(red: 0.89, green: 0.918, blue: 0.918, alpha: 1).cgColor
//        self.contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
//
//        image1.snp.makeConstraints { make in
//            make.top.equalTo(18)
//            make.leading.equalTo(27)
//            make.width.height.equalTo(41)
//        }
//
//        doorName.snp.makeConstraints { make in
//            make.leading.equalTo(image1.snp.trailing).inset(-14)
//            make.top.equalTo(22)
//        }
//
//        doorType.snp.makeConstraints { make in
//            make.top.equalTo(doorName.snp.bottom)
//            make.leading.equalTo(image1.snp.trailing).inset(-14)
//        }
//
//        doorCondition.snp.makeConstraints { make in
//            make.top.equalTo(doorType.snp.bottom).inset(-27)
//            make.centerX.equalTo(self.contentView.snp.centerX)
//        }
//    }
//}
