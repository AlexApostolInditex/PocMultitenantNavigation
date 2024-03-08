//
//  File.swift
//  
//
//  Created by alexandru.apostol on 6/3/24.
//

import Foundation

protocol LoginViewModelProtocol {
    func didPressGoToRegister()
    func didPressLoginButton()
}


final class LoginViewModel {

    private let coordinatorOutput: (LoginViewOutput) -> Void

    init(coordinatorOutput: @escaping (LoginViewOutput) -> Void) {
        self.coordinatorOutput = coordinatorOutput
    }
    
}

extension LoginViewModel: LoginViewModelProtocol {
    public func didPressGoToRegister() {
        coordinatorOutput(.goToRegister)
    }

    public func didPressLoginButton() {
        coordinatorOutput(.didLogin(result: true))
    }
}
