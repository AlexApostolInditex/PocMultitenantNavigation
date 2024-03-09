//
//  CoordinatorTests.swift
//  MultitenantNavigationPocTests
//
//  Created by alexandru.apostol on 9/3/24.
//
import UIKit
import XCTest
@testable import MultitenantNavigationPoc

final class CoordinatorTests: XCTestCase {

    var mockParent: MockParentCoordinator!
    var mockChild: MockChildCoordinator!
    var navigationController: MockNavigationController!

    override func setUpWithError() throws {
        navigationController = MockNavigationController()
        mockParent = MockParentCoordinator(navigationController: navigationController)
        mockChild = MockChildCoordinator(navigationController: navigationController)
    }

    override func tearDown() {
        navigationController = nil
        mockParent = nil
        mockChild = nil
    }


    func testPop() throws {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        mockParent.start()
        let child = try XCTUnwrap(mockParent.children.first as? MockChildCoordinator)
        XCTAssertTrue(mockParent.children.count == 1)
        XCTAssertTrue(navigationController.delegate is MockChildCoordinator)


        navigationController.popViewController(animated: true)

        XCTAssertTrue(mockParent.children.isEmpty)
        XCTAssertNil(navigationController.delegate)

    }
}

class MockParentCoordinator: Coordinator {
    var parentCoordinator: ( any Coordinator)? = nil

    var children: [any Coordinator] = []

    var navigationController: UINavigationController

    enum State {
        case inital
    }


    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.setViewControllers([MockParentFirstViewController()], animated: false)
        let child = MockChildCoordinator(navigationController: navigationController, parentCoordinator: self)
        children.append(child)
        child.start()
    }
}

class MockChildCoordinator: NSObject, Coordinator {
    var parentCoordinator: ( any Coordinator)? = nil

    var children: [any Coordinator] = []

    var navigationController: UINavigationController

    enum State {
    }

    init(navigationController: UINavigationController, parentCoordinator: ( any Coordinator)? = nil) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        super.init()
        navigationController.delegate = self
    }

    func start() {
        let mockChild = MockChildFirstViewController()
        navigationController.pushViewController(mockChild, animated: false)
        navigationController.simulateAppearance()
    }
}

private class MockChildFirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

     init() {
         super.init(nibName: nil, bundle: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class MockParentFirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MockChildCoordinator: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard
            let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(fromViewController) else {
            return
        }

        if (fromViewController is MockChildFirstViewController) {
            parentCoordinator?.childDidFinish(self)
        }
    }
}

class MockNavigationController: UINavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
    }
}

extension UINavigationController {
    func simulateAppearance() {
        if !isViewLoaded {
            loadViewIfNeeded()
        }

        beginAppearanceTransition(true, animated: false)
        endAppearanceTransition()
    }
}
