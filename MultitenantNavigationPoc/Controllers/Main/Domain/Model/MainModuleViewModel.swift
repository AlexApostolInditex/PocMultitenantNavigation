//
//  MainModuleViewModel.swift
//  MultitenantNavigationPoc
//
//  Created by alexandru.apostol on 6/3/24.
//

import Foundation

public protocol MainModuleViewModelProtocol {

}


public final class MainModuleViewModel: MainModuleViewModelProtocol {
    private let coordinatorOutput: (MainModuleViewOutput) -> Void

    public init(coordinatorOutput: @escaping (MainModuleViewOutput) -> Void) {
        self.coordinatorOutput = coordinatorOutput
    }
}
