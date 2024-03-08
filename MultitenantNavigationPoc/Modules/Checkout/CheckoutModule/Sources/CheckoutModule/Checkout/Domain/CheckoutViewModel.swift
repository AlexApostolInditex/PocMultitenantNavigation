//
//  File.swift
//  
//
//  Created by alexandru.apostol on 6/3/24.
//

import Foundation
import Combine

protocol CheckoutViewModelProtocol {
    func didPressContinue()
}

final class CheckoutViewModel {
    private let coordinatorOutput: (CheckoutViewOutput) -> Void
    private var params: CheckoutParams
    private let userIdentitySignal: AnyPublisher<CheckoutParams, Never>
    private var cancellable: AnyCancellable? = nil

    init(userIdentitySignal: AnyPublisher<CheckoutParams, Never>, params: CheckoutParams, coordinatorOutput: @escaping (CheckoutViewOutput) -> Void) {
        self.coordinatorOutput = coordinatorOutput
        self.params = params
        self.userIdentitySignal = userIdentitySignal
        listenIdentityChanges()
    }

    deinit {
        cancellable = nil
    }

    private func listenIdentityChanges() {
       cancellable =  userIdentitySignal.sink { [weak self] params in
           self?.params = params
        }
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
