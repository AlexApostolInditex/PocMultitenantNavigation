//
//  File.swift
//  
//
//  Created by alexandru.apostol on 6/3/24.
//

import Foundation

protocol CheckoutViewModelProtocol {
    func didPressContinue()
}

final class CheckoutViewModel {
    private let coordinatorOutput: (CheckoutViewOutput) -> Void
    private let params: CheckoutParams

    init(params: CheckoutParams, coordinatorOutput: @escaping (CheckoutViewOutput) -> Void) {
        self.coordinatorOutput = coordinatorOutput
        self.params = params
    }
}

extension CheckoutViewModel: CheckoutViewModelProtocol {
    func didPressContinue() {
        params.isUserLogin ? coordinatorOutput(.goToShippingMethods) : coordinatorOutput(.goToLogin)
    }
}

public struct CheckoutParams {
    let isUserLogin: Bool

    public init(isUserLogin: Bool) {
        self.isUserLogin = isUserLogin
    }
}
