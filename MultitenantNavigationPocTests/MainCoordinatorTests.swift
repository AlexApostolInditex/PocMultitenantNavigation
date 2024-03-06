//
//  MainCoordinatorTests.swift
//  MultitenantNavigationPocTests
//
//  Created by alexandru.apostol on 6/3/24.
//

import UIKit
import XCTest
@testable import MultitenantNavigationPoc

final class MainCoordinatorTests: XCTestCase {

    private var sut: MainModuleCoordinator!
    private var navigator: UINavigationController!

    override func setUpWithError() throws {
        navigator = UINavigationController()
        sut = MainModuleCoordinator(navigator: navigator)
    }

    override func tearDown() {
        navigator = nil
        sut = nil
    }

    func test_givenInitialState_willShowMainModule() {
        sut.start()
        XCTAssertEqual(sut.currentState, MainModuleCoordinator.State.willShowMainModule)
    }

    func test_givenDidShowMainModuleState_willShowLoginFlow() {
        sut.start(with: .didShowMainModule(output: .goToLogin))
        XCTAssertEqual(sut.currentState, MainModuleCoordinator.State.willShowLogin)
    }

    func test_givenDidShowMainModuleState_willShowCheckoutFlow() {
        sut.start(with: .didShowMainModule(output: .goToCheckout))
        XCTAssertEqual(sut.currentState, MainModuleCoordinator.State.willShowCheckout)
    }

}

