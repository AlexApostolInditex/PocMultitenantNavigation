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
    public var watcher: ((State) -> Bool)?
    
    public var parentCoordinator: (any Coordinator)?
    
    public var children: [any Coordinator] = []

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

    init(parentCoordinator: (any Coordinator)? = nil, navigationController: UINavigationController) {
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

    public func willManage<State>(_ state: State) -> Bool {
        if let state  = state as? LoginCoordinator.State {
            switch state {
            case .willShowProfile:
                navigationController.popViewController(animated: true)
                currentState = .willShowShippingMethods
                loop()
                return true
            case .didShowRegister:
                navigationController.popUntil(CheckoutViewController.self)
                currentState = .willShowShippingMethods
                loop()
                return true
            default: break

            }
        }
        return false
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
        let viewController = CheckoutFactory.makeCheckoutModule(
            userIdentitySignal: StateRepository.userStateSignal.map({ identity in
                CheckoutParams(isUserLogin: identity == .user)
            }).eraseToAnyPublisher(),
            params: checkoutParams
        ) { [weak self] output in
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
//        loginCoordinator.start { [weak self] state in
//            switch state {
//            case .willShowProfile:
//                    self?.navigationController.popViewController(animated: true)
//                    self?.currentState = .willShowShippingMethods
//                    self?.loop()
//                return true
//            case .didShowRegister:
//                self?.navigationController.popUntil(CheckoutViewController.self)
//                self?.currentState = .willShowShippingMethods
//                self?.loop()
//                return true
//            default: break
//
//            }
//            return false
//        }
    }
}

extension CheckoutCoordinator: UINavigationControllerDelegate, UIGestureRecognizerDelegate {
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

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}

extension UINavigationController {
    func popUntil(_ vc: UIViewController.Type) {
        viewControllers.forEach { controller in
            if !(controller === vc) {
                self.popViewController(animated: true)
            } else {
               return
            }
        }
    }
}
