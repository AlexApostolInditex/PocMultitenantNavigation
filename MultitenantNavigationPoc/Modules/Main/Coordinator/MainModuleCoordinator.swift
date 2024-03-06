//
//  MainModuleCoordinator.swift
//  MultitenantNavigationPoc
//
//  Created by alexandru.apostol on 6/3/24.
//

import Foundation
import UIKit

public final class MainModuleCoordinator: Coordinator {
    public var parentCoordinator: Coordinator?

    public var children: [Coordinator] = []

     public enum State: Equatable {
        case initial
        case willShowMainModule
        case willShowCheckout
        case willShowLogin
        case didShowMainModule(output: MainModuleViewOutput)
    }

    private let navigator: UINavigationController
    private (set) var currentState: State = .initial

    public func start() {
        loop()
    }

    public func start(with state: State) {
        currentState = state
        loop()
    }

    init(navigator: UINavigationController) {
        self.navigator = navigator
    }

    private func loop() {
        self.currentState = next(currentState)

        switch currentState {
        case .willShowMainModule:
            showMainModule()
        case .willShowCheckout:
            showCheckoutModule()
        case .willShowLogin:
             showLoginModule()
        case .didShowMainModule, .initial:
            assertionFailure("Unexpected looping case")
        }
    }

    private func next(_ nextState: State) -> State {
        switch nextState {
        case .initial:
            return .willShowMainModule
        case .didShowMainModule(let output):
            switch output {
            case .goToLogin:
                return .willShowLogin
            case .goToCheckout:
                return .willShowCheckout
            }
        case .willShowMainModule, .willShowLogin, .willShowCheckout:
            return nextState
        }
    }

    private func showMainModule() {
        let viewController = MainModuleFactory.makeMainModule { [weak self] output in
            switch output {
            case .goToLogin:
                self?.currentState = .didShowMainModule(output: .goToLogin)
            case .goToCheckout:
                self?.currentState = .didShowMainModule(output: .goToCheckout)
            }
        }

        navigator.setViewControllers([viewController], animated: true)
    }

    private func showLoginModule() {

    }

    private func showCheckoutModule() {

    }

}
