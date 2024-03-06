//
//  File.swift
//  
//
//  Created by alexandru.apostol on 6/3/24.
//

import Foundation
import UIKit

public final class LoginFactory {

    private init() {}

    public static func makeLoginModule(coordinatorOutput: @escaping (LoginViewOutput) -> Void) -> UIViewController {
        let model = LoginViewModel(coordinatorOutput: coordinatorOutput)
        let viewController = LoginViewController(viewModel: model)
        return viewController
    }
}
