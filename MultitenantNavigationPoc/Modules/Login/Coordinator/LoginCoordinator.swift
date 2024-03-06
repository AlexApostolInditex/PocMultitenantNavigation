//
//  LoginCoordinator.swift
//  MultitenantNavigationPoc
//
//  Created by alexandru.apostol on 6/3/24.
//

import Foundation
import UIKit
import LoginModule

public final class LoginCoordinator: NSObject, Coordinator {

    public var parentCoordinator: Coordinator?
    
    public var children: [Coordinator] = []

    public enum State {
        case initial
        case didShowLogin(output: LoginViewOutput)
        case willShowRegister
        case willShowLogin
    }

    private (set) var currentState: State = .initial
    public var navigationController: UINavigationController

    init(parentCoordinator: Coordinator? = nil, navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        super.init()
        navigationController.delegate = self
    }

    public func start() {
        currentState = .initial
        loop()
    }

    deinit {
        print("Deinit: \(String(describing: self))")
    }

    private func loop() {
        self.currentState = next(currentState)

        switch currentState {

        case .willShowRegister:
            showRegisterFlow()

        case .willShowLogin:
            showLoginFlow()

        case .initial, .didShowLogin:
            assertionFailure("Unexpected looping case")
        }
    }

    private func next(_ nextState: State) -> State {
        switch nextState {
        case .initial:
            return .willShowLogin

        case .didShowLogin(let output):
            switch output {
            case .goToRegister:
                return .willShowRegister
            }
            
        case .willShowRegister, .willShowLogin:
            return nextState
        }
    }

    private func showRegisterFlow() {
        let viewController = RegisterFactory.makeRegisterModule { output in
            switch output {
            case .didRegister(result: let result):
                StateRepository.updateUserState(to: result ? .user : .guest)
            }
        }

        navigationController.pushViewController(viewController, animated: true)
    }

    private func showLoginFlow() {
        let viewController = LoginFactory.makeLoginModule { [weak self] output in
            switch output {
            case .goToRegister:
                self?.currentState = .willShowRegister
                self?.loop()
            }
        }

        navigationController.pushViewController(viewController, animated: true)
    }
}

extension LoginCoordinator: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard
            let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(fromViewController) else {
            return
        }

        if (fromViewController is LoginViewController) {
            parentCoordinator?.childDidFinish(self)
        }
    }
}
