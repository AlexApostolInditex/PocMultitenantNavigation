//
//  MainModuleFactory.swift
//  MultitenantNavigationPoc
//
//  Created by alexandru.apostol on 6/3/24.
//

import Foundation
import UIKit

public final class MainModuleFactory {
    private init() {}

    public static func makeMainModule(coordinatorOutput: @escaping (MainModuleViewOutput) -> Void) -> UIViewController {
        let model = MainModuleViewModel(coordinatorOutput: coordinatorOutput)
        let viewController = MainViewController(viewModel: model)
        return viewController
    }
}
