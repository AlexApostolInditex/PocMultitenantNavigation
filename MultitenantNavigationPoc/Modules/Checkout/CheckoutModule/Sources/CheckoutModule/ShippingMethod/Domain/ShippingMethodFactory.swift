//
//  File.swift
//  
//
//  Created by alexandru.apostol on 7/3/24.
//

import Foundation
import UIKit

public final class ShippingMethodFactory {
    private init () {}

    public static func makeShippingMethod() -> UIViewController {
        ShippingMethodViewController()
    }
}
