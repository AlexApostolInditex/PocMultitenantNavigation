//
//  LoginCoordinatorTests.swift
//  MultitenantNavigationPocTests
//
//  Created by alexandru.apostol on 8/3/24.
//

import UIKit
import XCTest
@testable import MultitenantNavigationPoc

final class LoginCoordinatorTests: XCTestCase {

    var sut: LoginCoordinator!
    var mockNavigationController: UINavigationController!

    override func setUpWithError() throws {
        mockNavigationController = UINavigationController()
        sut = LoginCoordinator(parentCoordinator: nil, navigationController: mockNavigationController)
    }

    override func tearDownWithError() throws {
        mockNavigationController = nil
        sut = nil
    }

    func test_loginCoordinator_givenInitialState_willShowLoginView() {
        sut.start()
        XCTAssertEqual(sut.currentState, .willShowLogin)
    }

    func test_loginCoordinator_given_loginFlowFinishedWithRegisterOutput_willShowRegisterFlow() {
        sut.start(with: .didShowLogin(output: .goToRegister))
        XCTAssertEqual(sut.currentState, .willShowRegister)
    }

    func test_loginCoordinator_given_loginFlowFinishedWithLogingOutput_willProfile() {
        sut.start(with: .didShowLogin(output: .didLogin(result: true)))
        XCTAssertEqual(sut.currentState, .willShowProfile)
    }

    func test_loginCoordinator_given_watcher_informsWatcher() {
        var capturedState: [LoginCoordinator.State] = []
        let navigationStateWatcher: (LoginCoordinator.State) -> Bool = { state in
            capturedState.append(state)
            return true
        }

        sut.start(navigationStateWatcher: navigationStateWatcher)
        XCTAssertEqual(capturedState, [.initial])
    }
}
