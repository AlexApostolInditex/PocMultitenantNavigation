//
//  MainModuleViewModel.swift
//  MultitenantNavigationPoc
//
//  Created by alexandru.apostol on 6/3/24.
//

import Foundation

public protocol MainModuleViewModelProtocol {
    func didPressCheckoutButton()
    func didPressLoginButton()
}


public final class MainModuleViewModel {
    private let coordinatorOutput: (MainModuleViewOutput) -> Void

    public init(coordinatorOutput: @escaping (MainModuleViewOutput) -> Void) {
        self.coordinatorOutput = coordinatorOutput
    }
}


extension MainModuleViewModel: MainModuleViewModelProtocol {
    public func didPressCheckoutButton() {
        coordinatorOutput(.goToCheckout)
    }
    
    public func didPressLoginButton() {
        coordinatorOutput(.goToLogin)
    }
}
