//
//  API.swift
//  ProjectDoors
//
//  Created by Artem Manakov on 05.01.2023.
//

import Foundation

final class API {
    func getDoorsList(completion: @escaping ([Door]) -> ()) {
        let defaultQueue = DispatchQueue.global()
        defaultQueue.asyncAfter(deadline: .now() + 3) {
            let response = [Door(name: "Front", type: "Office", status: .locked)]
            completion(response)
        }
    }
    
    func changeDoorStatus(door: Door, neededStatus: Status, completion: @escaping (Door) -> ()) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            completion(Door(name: door.name, type: door.type, status: neededStatus))
        }
    }
}
