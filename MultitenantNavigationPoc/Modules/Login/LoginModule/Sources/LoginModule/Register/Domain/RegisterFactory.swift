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

    public static func makeRegisterModule() -> UIViewController {
        RegisterViewController()
    }
}
