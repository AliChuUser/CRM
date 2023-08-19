//
//  ApplicationCoordinator.swift
//  CRM
//
//  Created by Aleksei Chudin on 19.08.2023.
//

import Foundation

class ApplicationCoordinator: BaseCoordinator {
    
    let window: UIWindow
    
    let payload: [String: AnyObject]?
    
    weak var serviceContainer: ServiceContainer?
    
    var navigationController: CRMNavigationController?
    
    init(window: UIWindow, serviceContainer: ServiceContainer, payload: [String: AnyObject]? = nil) {
        self.window = window
        self.serviceContainer = serviceContainer
        self.payload = payload
        self.navigationController = CRMNavigationController()
        super.init()
    }
    
    override func start() {
//        showWelcomeCoordinator()
//        showAuthorizationCoordinator()
        showTabBarCoordinator()
    }
    
    
    // Показ экрана приветствия
    private func showWelcomeCoordinator() {
        let welcomeCoordinator = WelcomeCoordinator(navigationController: navigationController) {
            self.showAuthorizationCoordinator()
        }
        welcomeCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    // Показ экрана авторизации
    private func showAuthorizationCoordinator() {
        guard let serviceContainer = self.serviceContainer else { return }
        let authorizationCoordinator = AuthorizationCoordinator(navigationController: navigationController, serviceContainer: serviceContainer, onFinish: {
            self.showTabBarCoordinator()
        })
        authorizationCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    // Показ основного экрана с таб баром
    private func showTabBarCoordinator() {
        guard let serviceContainer = self.serviceContainer else { return }
        let tabBarController = CRMTabBarController()
        let tabBarCoordinator = TabBarCoordinator(tabBarController: tabBarController, serviceContainer: serviceContainer, onExit: {
            self.start()
        })
        tabBarCoordinator.start()
        window.rootViewController = tabBarCoordinator.tabBarController
        window.makeKeyAndVisible()
    }
}
