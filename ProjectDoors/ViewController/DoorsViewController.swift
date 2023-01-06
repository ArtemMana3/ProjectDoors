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
    
    private lazy var titleLabel1: UILabel = {
        let lbl = UILabel()
        lbl.text = "Inter"
        lbl.font = UIFont(name: "Sk-Modernist-Bold", size: 26.0)
        lbl.textColor = UIColor(red: 0.655, green: 0.659, blue: 0.667, alpha: 1)
        return lbl
    }()
    
    private lazy var titleLabel2: UILabel = {
        let lbl = GradientLabel()
        lbl.text = "QR"
        lbl.font = UIFont(name: "Sk-Modernist-Bold", size: 26.0)
        lbl.gradientColors = [UIColor(red: 0, green: 0.267, blue: 0.545, alpha: 1).cgColor,
                              UIColor(red: 0, green: 0.561, blue: 0.827, alpha: 1).cgColor]
        return lbl
    }()
    
    private lazy var settingsButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 13
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.customLightGray.cgColor
        btn.setImage(UIImage(named: "Setting"), for: .normal)
        btn.addTarget(self, action: #selector(openSettings), for: .touchDown)
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
        return lbl
    }()
    
    private lazy var doorsLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "My doors"
        lbl.textColor = UIColor.customDarkBlue
        lbl.font = UIFont(name: "Sk-Modernist-Bold", size: 20.0)
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
        titleLabel1.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(16)
            make.leading.equalToSuperview().inset(24)
        }
        
        titleLabel2.snp.makeConstraints { make in
            make.top.equalTo(titleLabel1)
            make.leading.equalTo(titleLabel1.snp.trailing).inset(-4)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(27)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(6)
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
            make.top.equalTo(titleLabel1.snp.bottom).inset(-50)
            make.leading.equalTo(titleLabel1)
        }
        
        doorsLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel1)
            make.top.equalTo(greetingLabel.snp.bottom).inset(-120)
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
        [titleLabel1, titleLabel2, settingsButton, homeImageView, greetingLabel, doorsLabel, tableView, activityIndicator].forEach {
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
    
    @objc private func openSettings() {
        let actionSheet = UIAlertController(title: "Settings", message: "Choose an option", preferredStyle: .actionSheet)
        let colorAction = UIAlertAction(title: "Color", style: .default) { (action) in
            // handle
        }
        actionSheet.addAction(colorAction)

        let doorAction = UIAlertAction(title: "Door", style: .default) { (action) in
            // handle
        }
        actionSheet.addAction(doorAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        actionSheet.addAction(cancelAction)

        present(actionSheet, animated: true, completion: nil)
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
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let door = doors[indexPath.row]
        if door.status == .unlocking { return }
        let oppositeStatus = door.status.oppositeStatus
        
        doors[indexPath.row].status = .unlocking
        self.tableView.reloadRows(at: [indexPath], with: .fade)
        
        guard let cell = tableView.cellForRow(at: indexPath) as? DoorCell else { return }
        
        api.changeDoorStatus(door: door, neededStatus: oppositeStatus, cell: cell) { [weak self] door in
            self?.doors[indexPath.row] = door
            DispatchQueue.main.async {
                self?.tableView.reloadRows(at: [indexPath], with: .fade)
            }
            if door.status == .unlocked {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.tableView(tableView, didSelectRowAt: indexPath)
                }
            }
        }
    }
}

