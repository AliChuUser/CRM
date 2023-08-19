//
//  AuthorizationCoordinator.swift
//  CRM
//
//  Created by Aleksei Chudin on 19.08.2023.
//

import Foundation

class AuthorizationCoordinator : BaseCoordinator {
    
    private var navigationController: CRMNavigationController?
    
    private weak var serviceContainer: ServiceContainer?
    
    init(navigationController: CRMNavigationController?, serviceContainer: ServiceContainer, onFinish: (() -> Void)?) {
        super.init()
        self.serviceContainer = serviceContainer
        self.onFinished = onFinish
        self.navigationController = navigationController
    }
    
    override func start() {
        showAuthorizationCoordinator()
    }
    
    private func showAuthorizationCoordinator() {
        guard let serviceContainer = self.serviceContainer, let onFinished = self.onFinished else { return }
        let authorizationModule = AuthorizationRouter.createModule(serviceContainer: serviceContainer, onFinished: onFinished)
        navigationController?.pushViewController(authorizationModule, animated: true)
    }
    
}
