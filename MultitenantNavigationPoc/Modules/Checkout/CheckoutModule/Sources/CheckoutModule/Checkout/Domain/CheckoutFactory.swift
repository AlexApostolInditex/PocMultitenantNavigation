//
//  File.swift
//  
//
//  Created by alexandru.apostol on 6/3/24.
//

import Combine
import Foundation
import UIKit

public final class CheckoutFactory {
    private init() {}

    public static func makeCheckoutModule(userIdentitySignal: AnyPublisher<CheckoutParams, Never>, params: CheckoutParams, coordinatorOutput: @escaping (CheckoutViewOutput) -> Void) -> UIViewController {
        let model = CheckoutViewModel(userIdentitySignal: userIdentitySignal, params: params, coordinatorOutput: coordinatorOutput)
        let viewController = CheckoutViewController(viewModel: model)
        return viewController
    }
}
