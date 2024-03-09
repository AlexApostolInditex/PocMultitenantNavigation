//
//  CheeckoutCoordinatorTests.swift
//  MultitenantNavigationPocTests
//
//  Created by alexandru.apostol on 8/3/24.
//

import XCTest
import UIKit
@testable import MultitenantNavigationPoc

final class CheckoutCoordinatorTests: XCTestCase {

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

    func test_start_willShowCheckout() {
        sut.start()
        XCTAssertEqual(sut.currentState, .willShowCheckout)
    }

    func test_currentState_give_didShowCheckWithLoginOutput_shouldGoToLogin() throws {
        sut.start(state: .didShowCheckout(.goToLogin))
        XCTAssertEqual(sut.currentState, .willShowLogin)
        let loginCoordinator = try XCTUnwrap(sut.children.first as? LoginCoordinator)
        XCTAssertEqual(loginCoordinator.currentState, .willShowLogin)
    }

    func test_childCoordinatorStateManage_give_login_shows_shippingMethod() throws {
        sut.start(state: .didShowCheckout(.goToLogin))
        XCTAssertEqual(sut.currentState, .willShowLogin)
        let loginCoordinator = try XCTUnwrap(sut.children.first as? LoginCoordinator)
        XCTAssertEqual(loginCoordinator.currentState, .willShowLogin)
        loginCoordinator.start(with: .didShowRegister)

        XCTAssertEqual(sut.currentState, .willShowShippingMethods)
        loginCoordinator.start(with: .didShowRegister)

        loginCoordinator.start(with: .didShowLogin(output: .didLogin(result: true)))
        XCTAssertEqual(sut.currentState, .willShowShippingMethods)
    }

    func test_currentState_give_didShowCheckWithShippingOutput_shouldGoToShippingMethods() {
        sut.start(state: .didShowCheckout(.goToShippingMethods))
        XCTAssertEqual(sut.currentState, .willShowShippingMethods)
    }

}
