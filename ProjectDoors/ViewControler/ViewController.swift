//
//  ViewController.swift
//  ProjectDoors
//
//  Created by Artem Manakov on 04.01.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    var doors = [Door]()
    private let api = API()
    
    lazy var titleName: UILabel = {
        let lbl = UILabel()
        
        let string = "Inter QR"

        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 27), range: NSRange(location: 0, length: 8))
        attributedString.addAttribute(.foregroundColor, value: UIColor(red: 0.655, green: 0.659, blue: 0.667, alpha: 1), range: NSRange(location: 0, length: 5))
        attributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: NSRange(location: 6, length: 2))
        lbl.attributedText = attributedString
        
        view.addSubview(lbl)
        return lbl
    }()
    
    lazy var settings: UIButton = {
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 13
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor(red: 0.882, green: 0.91, blue: 0.91, alpha: 1).cgColor
        btn.setImage(UIImage(named: "Setting"), for: .normal)
        //        btn.showsTouchWhenHighlighted = true
        //      btn.addTarget(self, action: #selector(handleAnswer(_:)), for: .touchUpInside)
        view.addSubview(btn)
        return btn
    }()
    
    lazy var home: UIImageView = {
        let homeImage = UIImage(named: "Home")
        let homeImageView = UIImageView(image: homeImage)
        homeImageView.contentMode = .scaleAspectFit
        
        view.addSubview(homeImageView)
        return homeImageView
    }()

    lazy var greeting: UILabel = {
        let lbl = UILabel()
        //      lbl.numberOfLines = 1
        lbl.text = "Welcome"
        lbl.font = UIFont(name: "Sk-Modernist-Bold", size: 35.0)
        lbl.font = UIFont.boldSystemFont(ofSize: 35)
        
        view.addSubview(lbl)
        return lbl
    }()
    
    lazy var doorsLbl: UILabel = {
        let lbl = UILabel()
        //      lbl.numberOfLines = 1
        lbl.text = "My doors"
        lbl.textColor = UIColor(red: 0.196, green: 0.216, blue: 0.333, alpha: 1)
        lbl.font = UIFont(name: "Sk-Modernist-Bold", size: 20.0)
        lbl.font = UIFont.boldSystemFont(ofSize: 20) // ?????

        view.addSubview(lbl)
        return lbl
    }()
    
    lazy var table: UITableView = {
        let table = UITableView()
        table.register(DoorCell.self, forCellReuseIdentifier: DoorCell.identifier)
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none

        view.addSubview(table)
        return table
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityInd = UIActivityIndicatorView(style: .large)
        
        view.addSubview(activityInd)
        return activityInd
    }()
    
    func setupConstraints() {
        titleName.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.top.equalToSuperview().inset(77)
        }
        
        settings.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(27)
            make.top.equalToSuperview().inset(63)
            make.width.equalTo(45)
            make.height.equalTo(45)
        }
        
        home.snp.makeConstraints { make in
            make.top.equalTo(settings.snp.bottom)
            make.trailing.equalToSuperview().inset(-4)
            make.width.equalTo(189)
            make.height.equalTo(168)
        }

        greeting.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.top.equalToSuperview().inset(157)
//            make.width.equalTo(148)
//            make.height.equalTo(92) // ???????????
        }
        
        doorsLbl.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.top.equalToSuperview().inset(307)
        }
        
        table.snp.makeConstraints { make in
            make.top.equalTo(doorsLbl.snp.bottom).inset(-30)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalTo(table.snp.centerX)
            make.top.equalTo(table.snp.top).inset(30)

        }
    }
    
    private func getDoorsList() {
        self.activityIndicator.startAnimating()
        api.getDoorsList { [weak self] doors in
            self?.doors = doors
            DispatchQueue.main.async { // Change UI
                self?.activityIndicator.stopAnimating()
                self?.table.reloadData()
            }

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        getDoorsList()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doors.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DoorCell.identifier, for: indexPath) as! DoorCell
        cell.set(door: doors[indexPath.row])
//        print(doors[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let door = doors[indexPath.row]
        
        var neededStatus: Status
        if door.status.status == "Locked" {
            neededStatus = .unlocked
        } else if door.status.status == "Unlocked"{
            neededStatus = .locked
        } else {
            return
        }
        
        doors[indexPath.row].status = DoorStatus(status: .unlocking)
        self.table.reloadRows(at: [indexPath], with: .fade)
        api.openDoor(door: door, neededStatus: neededStatus) { [weak self] door in
            self?.doors[indexPath.row] = door
            DispatchQueue.main.async { // Change UI
                self?.table.reloadRows(at: [indexPath], with: .fade)
            }
        }
    }
}

