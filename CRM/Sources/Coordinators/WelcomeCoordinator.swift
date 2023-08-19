//
//  WelcomeCoordinator.swift
//  CRM
//
//  Created by Aleksei Chudin on 19.08.2023.
//

import Foundation

class WelcomeCoordinator: BaseCoordinator {
    
    var navigationController: CRMNavigationController?
    
    init(navigationController: CRMNavigationController?, onFinish: (() -> Void)?) {
        super.init()
        self.onFinished = onFinish
        self.navigationController = navigationController
    }
    
    override func start() {
        showWelcomeCoordinator()
    }
    
    private func showWelcomeCoordinator() {
        let welcomeModule = WelcomeRouter.createModule(onFinished: {
            self.onFinished?()
        })
        navigationController?.pushViewController(welcomeModule, animated: true)
    }
}
