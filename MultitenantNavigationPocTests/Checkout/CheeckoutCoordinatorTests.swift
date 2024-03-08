//
//  CheeckoutCoordinatorTests.swift
//  MultitenantNavigationPocTests
//
//  Created by alexandru.apostol on 8/3/24.
//

import XCTest
import UIKit
@testable import MultitenantNavigationPoc

final class CheeckoutCoordinatorTests: XCTestCase {

    var sut: CheckoutCoordinator!
    var mockNavigationController: UINavigationController!

    override func setUpWithError() throws {
        mockNavigationController = UINavigationController()
        sut = CheckoutCoordinator(navigationController: mockNavigationController)
    }

    override func tearDownWithError() throws {
        mockNavigationController = nil
        sut = nil
    }

}
