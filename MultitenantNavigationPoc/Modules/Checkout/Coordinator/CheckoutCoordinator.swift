//
//  CheckoutCoordinator.swift
//  MultitenantNavigationPoc
//
//  Created by alexandru.apostol on 6/3/24.
//

import Foundation
import CheckoutModule
import UIKit

public final class CheckoutCoordinator: NSObject, Coordinator {
    public var parentCoordinator: Coordinator?
    
    public var children: [Coordinator] = []

    public var navigationController: UINavigationController
    
    public enum State {
        case initial
        case willShowCheckout
        case didShowCheckout(CheckoutViewOutput)
        case willShowShippingMethods
        case willShowLogin
    }

    private (set) var currentState: State = .initial

    public func start() {
        loop()
    }

    deinit {
        print("Deinit: \(String(describing: self))")
    }

    init(parentCoordinator: Coordinator? = nil, navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        super.init()
        navigationController.delegate = self
    }

    private func loop() {
        currentState = next(currentState)

        switch currentState {
        case .willShowCheckout:
            showCheckout()

        case .willShowShippingMethods:
            showShippingMethods()

        case .willShowLogin:
            showLogin()

        case .initial, .didShowCheckout:
            assertionFailure("Unexpected loop case")
        }
    }

    private func next(_ nextState: State) -> State {
        switch nextState {
        case .initial:
            return .willShowCheckout
        case .didShowCheckout(let checkoutViewOutput):
            switch checkoutViewOutput {
            case .goToShippingMethods:
                return .willShowCheckout
            case .goToLogin:
                return .willShowLogin
            }
        case .willShowShippingMethods, .willShowCheckout, .willShowLogin:
            return nextState
        }
    }

    private func showCheckout() {
        let checkoutParams = CheckoutParams(isUserLogin: StateRepository.getUserState() == .user)
        let viewController = CheckoutFactory.makeCheckoutModule(params: checkoutParams) { [weak self] output in
            switch output {

            case .goToShippingMethods:
                self?.currentState = .willShowShippingMethods
                self?.loop()

            case .goToLogin:
                self?.currentState = .willShowLogin
                self?.loop()
            }
        }

        navigationController.pushViewController(viewController, animated: true)
    }


    private func showShippingMethods() {
        let viewController = ShippingMethodFactory.makeShippingMethod()
        navigationController.pushViewController(viewController, animated: true)
    }

    private func showLogin() {
        let loginCoordinator = LoginCoordinator(parentCoordinator: self, navigationController: navigationController)
        children.append(loginCoordinator)
        loginCoordinator.start()
    }
}

extension CheckoutCoordinator: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard
            let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(fromViewController) else {
            return
        }

        if (fromViewController is CheckoutViewController) {
            parentCoordinator?.childDidFinish(self)
        }
    }
}