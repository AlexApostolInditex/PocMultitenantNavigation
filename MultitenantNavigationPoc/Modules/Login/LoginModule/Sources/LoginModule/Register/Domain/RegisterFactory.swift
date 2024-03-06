//
//  File.swift
//  
//
//  Created by alexandru.apostol on 6/3/24.
//

import Foundation
import UIKit

public final class RegisterFactory {
    private init () {}

    public static func makeRegisterModule(coordinatorOutput: @escaping (RegisterViewOutput) -> Void) -> UIViewController {
        let viewModel = RegisterViewModel(coordinatorOutput: coordinatorOutput)
        let viewController = RegisterViewController(viewModel: viewModel)
        return viewController
    }
}
