//
//  File.swift
//  
//
//  Created by alexandru.apostol on 6/3/24.
//

import Foundation

public enum LoginViewOutput: Equatable {
    case goToRegister
    case didLogin(result: Bool)
}
