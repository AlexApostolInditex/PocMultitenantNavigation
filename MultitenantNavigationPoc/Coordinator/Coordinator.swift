//
//  Coordinator.swift
//  MultitenantNavigationPoc
//
//  Created by alexandru.apostol on 6/3/24.
//

import Foundation
import UIKit

public protocol Coordinator: AnyObject {
    func start()
    var parentCoordinator: Coordinator? { get }
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController { get }
}

public extension Coordinator {
    /// Removing a coordinator inside a children. This call is important to prevent memory leak.
    /// - Parameter coordinator: Coordinator that finished.
    func childDidFinish(_ coordinator : Coordinator){
        // Call this if a coordinator is done.
        for (index, child) in children.enumerated() {
            if child === coordinator {
                children.remove(at: index)
                break
            }
        }
    }
}
