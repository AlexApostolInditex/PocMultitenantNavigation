//
//  File.swift
//  
//
//  Created by alexandru.apostol on 6/3/24.
//

import Foundation

protocol RegisterViewModelProtocol {
    func registerUser()
    func unregisterUser()
}


final class RegisterViewModel {
    private let coordinatorOutput: (RegisterViewOutput) -> Void

    init(coordinatorOutput: @escaping (RegisterViewOutput) -> Void) {
        self.coordinatorOutput = coordinatorOutput
    }
}


extension RegisterViewModel: RegisterViewModelProtocol {
    func registerUser() {
        coordinatorOutput(.didRegister(result: true))
    }
    
    func unregisterUser() {
        coordinatorOutput(.didRegister(result: false))
    }
}
