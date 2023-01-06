//
//  DoorCell.swift
//  ProjectDoors
//
//  Created by Artem Manakov on 04.01.2023.
//

import UIKit
import SnapKit

final class DoorCell: UITableViewCell, ReusableCell {
    var door = Door(name: "Unknown", type: "Unknown", status: .locked)
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var view: UIView = {
        let view = UIView(frame: CGRect(x: 15, y: 0, width: UIScreen.main.bounds.width - 30, height: 115))
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 13
        view.layer.borderColor = UIColor.customLightGray.cgColor
        return view
    }()

    private lazy var imageLeft: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var imageRight: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var doorNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = door.name
        lbl.textColor = UIColor.customDarkBlue
        lbl.font = UIFont(name: "Sk-Modernist-Bold", size: 16.0)
        return lbl
    }()

    private lazy var doorTypeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = door.type
        lbl.textColor =  UIColor(red: 0.725, green: 0.725, blue: 0.725, alpha: 1)
        lbl.font = UIFont(name: "Sk-Modernist-Regular", size: 14.0)
        return lbl
    }()

    private lazy var doorStatusLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = door.status.rawValue
        lbl.font = UIFont(name: "Sk-Modernist-Bold", size: 15.0)
        return lbl
    }()
    
    lazy var circularProgressView: CircularProgressView = {
        let progressView = CircularProgressView(frame: CGRect(x: 0, y: 0, width: 22, height: 22), lineWidth: 2, rounded: false)
        progressView.progressColor = .customGreen
        progressView.progress = 0.0
        return progressView
    }()
    
    func setupConstraints() {
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

        doorNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageLeft.snp.trailing).inset(-14)
            make.top.equalTo(22)
        }

        doorTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(doorNameLabel.snp.bottom)
            make.leading.equalTo(doorNameLabel)
        }

        doorStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(doorTypeLabel.snp.bottom).inset(-27)
            make.centerX.equalTo(view.snp.centerX)
        }

        circularProgressView.snp.makeConstraints { make in
            make.top.equalTo(27)
            make.trailing.equalTo(-60)
        }
    }
    
    func setupCell() {
        addSubview(view)
        [imageLeft, imageRight, doorNameLabel, doorTypeLabel, doorStatusLabel, circularProgressView].forEach {
            view.addSubview($0)
        }
        setupConstraints()
    }
    
    func configureCell(with door: Door) {
        imageLeft.image = .getImageForCell(status: door.status, leftImage: true)
        imageRight.image = .getImageForCell(status: door.status, leftImage: false)
        
        if door.status != .unlocking {
            circularProgressView.isHidden = true
            imageRight.isHidden = false

        } else {
            imageRight.isHidden = true
            circularProgressView.isHidden = false
        }
        
        doorNameLabel.text = door.name
        doorTypeLabel.text = door.type
        doorStatusLabel.text = door.status.rawValue.capitalized + (door.status == .unlocking ? "..." : "")
        doorStatusLabel.textColor = UIColor.getStatusLableColor(status: door.status)
    }
    
    func getImage(status: Status, left: Bool) -> UIImage {
        switch status {
        case .locked:
            return left ? UIImage(named: "LockedCellLeft")! : UIImage(named: "LockedCellRight")!
        case .unlocking:
            return left ? UIImage(named: "UnlockingCellLeft")! : UIImage(named: "UnlockingCellRight")!
        case .unlocked:
            return left ? UIImage(named: "UnlockedCellLeft")! : UIImage(named: "UnlockedCellRight")!
        }
    }
}
