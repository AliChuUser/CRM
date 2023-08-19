//
//  BaseCoordinator.swift
//  CRM
//
//  Created by Aleksei Chudin on 19.08.2023.
//

import Foundation

class BaseCoordinator: Coordinator {
    
    var childsCoordinators: [Coordinator] = []
    
    var onFinished: (() -> Void)?
    
    var onExit: (() -> Void)?
    
    func start() {
    }
    
    func addCoordinator(coordinator: Coordinator) {
        childsCoordinators.append(coordinator)
    }
       
    func removeCoordinator(coordinator: Coordinator) {
        childsCoordinators = childsCoordinators.filter { $0 !== coordinator }
    }
}


protocol Coordinator: class {
    var childsCoordinators: [Coordinator] { get set }
    
    func start()
    
    func addCoordinator(coordinator: Coordinator)
    
    func removeCoordinator(coordinator: Coordinator)
}
