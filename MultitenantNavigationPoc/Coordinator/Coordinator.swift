//
//  Coordinator.swift
//  MultitenantNavigationPoc
//
//  Created by alexandru.apostol on 6/3/24.
//

import Foundation
import UIKit

public protocol Coordinator: AnyObject {
    associatedtype State
    var parentCoordinator: (any Coordinator)? { get }
    var children: [any Coordinator] { get set }
    var navigationController : UINavigationController { get }
    func start()
    func willManage<State>(_: State) -> Bool
}

public extension Coordinator {
    func willManage<State>(_: State) -> Bool { false }
}

public extension Coordinator {
    /// Removing a coordinator inside a children. This call is important to prevent memory leak.
    /// - Parameter coordinator: Coordinator that finished.
    func childDidFinish(_ coordinator : any Coordinator){
        // Call this if a coordinator is done.
        for (index, child) in children.enumerated() {
            if child === coordinator {
                if navigationController.delegate === coordinator as? UINavigationControllerDelegate {
                    navigationController.delegate = nil
                }
                if let parent = child.parentCoordinator, parent is UINavigationControllerDelegate {
                    navigationController.delegate = parent as? UINavigationControllerDelegate
                }
                children.remove(at: index)
                break
            }
        }
    }
}

