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
            let response = Door.doors
            completion(response)
        }
    }
    
    func changeDoorStatus(door: Door, neededStatus: Status, cell: DoorCell, completion: @escaping (Door) -> ()) {
        let totalUnitCount: Int64 = 100
        let prograss = Progress(totalUnitCount: totalUnitCount)
        Timer.scheduledTimer(withTimeInterval: 2 / Double(totalUnitCount), repeats: true) { timer in
            guard prograss.isFinished == false else {
                timer.invalidate()
                return
            }
            prograss.completedUnitCount += 1
            let prograssFloat = Float((prograss.fractionCompleted))
            DispatchQueue.main.async { // Change UI
                cell.circularProgressView.setProgress(to: prograssFloat)
            }
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            completion(Door(name: door.name, type: door.type, status: neededStatus))
            cell.circularProgressView.progress = 0.0
        }
    }
}
