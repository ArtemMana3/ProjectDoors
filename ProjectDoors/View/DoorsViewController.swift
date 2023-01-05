//
//  ViewController.swift
//  ProjectDoors
//
//  Created by Artem Manakov on 04.01.2023.
//

import UIKit
import SnapKit

final class DoorsViewController: UIViewController {
    private var doors = [Door]()
    private let api = API()
    
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        let string = "Inter QR"
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 27), range: NSRange(location: 0, length: 8))
        attributedString.addAttribute(.foregroundColor, value: UIColor(red: 0.655, green: 0.659, blue: 0.667, alpha: 1), range: NSRange(location: 0, length: 5))
        attributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: NSRange(location: 6, length: 2))
        lbl.attributedText = attributedString
        return lbl
    }()
    
    private lazy var settingsButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 13
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.customLightGray.cgColor
        btn.setImage(UIImage(named: "Setting"), for: .normal)
        return btn
    }()
    
    private lazy var homeImageView: UIImageView = {
        let homeImage = UIImage(named: "Home")
        let homeImageView = UIImageView(image: homeImage)
        homeImageView.contentMode = .scaleAspectFit
        return homeImageView
    }()

    private lazy var greetingLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Welcome"
        lbl.font = UIFont(name: "Sk-Modernist-Bold", size: 35.0)
        lbl.font = UIFont.boldSystemFont(ofSize: 35)
        return lbl
    }()
    
    private lazy var doorsLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "My doors"
        lbl.textColor = UIColor.customDarkBlue
        lbl.font = UIFont(name: "Sk-Modernist-Bold", size: 20.0)
        lbl.font = UIFont.boldSystemFont(ofSize: 20) // ?????
        return lbl
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(DoorCell.self, forCellReuseIdentifier: DoorCell.cellID)
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        return table
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityInd = UIActivityIndicatorView(style: .large)
        return activityInd
    }()
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.top.equalToSuperview().inset(77)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(27)
            make.top.equalToSuperview().inset(63)
            make.width.equalTo(45)
            make.height.equalTo(45)
        }
        
        homeImageView.snp.makeConstraints { make in
            make.top.equalTo(settingsButton.snp.bottom)
            make.trailing.equalToSuperview().inset(-4)
            make.width.equalTo(189)
            make.height.equalTo(168)
        }

        greetingLabel.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.top.equalToSuperview().inset(157)
        }
        
        doorsLabel.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.top.equalToSuperview().inset(307)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(doorsLabel.snp.bottom).inset(-30)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalTo(tableView.snp.centerX)
            make.top.equalTo(tableView.snp.top).inset(30)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getDoorsList()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        [titleLabel, settingsButton, homeImageView, greetingLabel, doorsLabel, tableView, activityIndicator].forEach {
            view.addSubview($0)
        }
        setupConstraints()
    }
    
    private func getDoorsList() {
        self.activityIndicator.startAnimating()
        api.getDoorsList { [weak self] doors in
            self?.doors = doors
            DispatchQueue.main.async { // Change UI
                self?.activityIndicator.stopAnimating()
                self?.tableView.reloadData()
            }

        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension DoorsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doors.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DoorCell.cellID, for: indexPath) as? DoorCell else {
            return UITableViewCell()
        }
        cell.configureCell(with: doors[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let door = doors[indexPath.row]
        if door.status == .unlocking { return }
        var oppositeStatus = door.status.oppositeStatus
        
        doors[indexPath.row].status = .unlocking
        self.tableView.reloadRows(at: [indexPath], with: .fade)
        
        api.changeDoorStatus(door: door, neededStatus: oppositeStatus) { [weak self] door in
            self?.doors[indexPath.row] = door
            DispatchQueue.main.async { // Change UI
                self?.tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
    }
}

