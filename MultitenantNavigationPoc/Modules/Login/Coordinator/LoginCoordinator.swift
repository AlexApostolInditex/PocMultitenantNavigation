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

    public enum State: Equatable {
        case initial
        case didShowLogin(output: LoginViewOutput)
        case willShowRegister
        case willShowLogin
        case didShowRegister
        case willShowProfile
    }

    private (set) var currentState: State = .initial
    
    public var navigationController: UINavigationController
    private var navigationStateWatcher: ((State) -> Bool)? = nil

    init(parentCoordinator: Coordinator? = nil, navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        super.init()
        navigationController.delegate = self
        navigationController.interactivePopGestureRecognizer?.delegate = self
    }

    public func start() {
        currentState = .initial
        loop()
    }

    public func start(with state: State) {
        currentState = state
        loop()
    }

    public func start(navigationStateWatcher: @escaping (State) -> Bool) {
        self.navigationStateWatcher = navigationStateWatcher
        currentState = .initial
        loop()
    }

    deinit {
        print("Deinit: \(String(describing: self))")
    }

    private func loop() {
        if let navigationStateWatcher = navigationStateWatcher, navigationStateWatcher(currentState) {return}

        self.currentState = next(currentState)

        switch currentState {

        case .willShowRegister:
            showRegisterFlow()

        case .willShowLogin:
            showLoginFlow()

        case .willShowProfile:
            willShowProfile()
            
        case .initial, .didShowLogin, .didShowRegister:
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

            case .didLogin:
                return .willShowProfile
            }
            
        case .willShowRegister, .willShowLogin, .didShowRegister, .willShowProfile:
            return nextState
        }
    }

    private func showRegisterFlow() {
        let viewController = RegisterFactory.makeRegisterModule { [weak self] output in
            switch output {
            case .didRegister(result: let didRegister):
                StateRepository.updateUserState(to: didRegister ? .user : .guest)
                print("UserIdentity: \(StateRepository.getUserState())")
                self?.navigationStateWatcher?(.didShowRegister)
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

            case .didLogin(let result):
                if result {
                    StateRepository.updateUserState(to: .user)
                        self?.currentState = .willShowProfile
                        self?.loop()
                } else {
                    // Show Error View
                }
            }
        }
        // MARK: Sheet presentation example
       // viewController.presentationController?.delegate = self
       // navigationController.present(viewController, animated: true)
        navigationController.pushViewController(viewController, animated: true)
    }

    private func willShowProfile() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .green
        viewController.title = "Profile"
        navigationController.popViewController(animated: true)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension LoginCoordinator: UINavigationControllerDelegate, UIAdaptivePresentationControllerDelegate, UIGestureRecognizerDelegate {
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

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }

    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        if presentationController.presentedViewController is LoginViewController {
            parentCoordinator?.childDidFinish(self)
        }
    }
}
